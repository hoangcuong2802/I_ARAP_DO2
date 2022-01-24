//
//  MessageViewController.swift
//  InfinitiWould
//
//  Created by DroneOrange on 2021/06/02.
//

import UIKit

class MessageViewController: UIViewController {

    @IBOutlet weak private var tbList: UITableView!
    @IBOutlet weak var constBottom: NSLayoutConstraint!
    @IBOutlet weak var constTop: NSLayoutConstraint!
    @IBOutlet weak var tfMessage: UITextField!
    
    private let objMsgListViewModel = ObjMsgListViewModel()
    private let objMsgInsViewModel = ObjMsgInsViewModel()
    
    private var arrResult = [ObjMsgItem]()
    private var prjctObjId = 0 //메세지를 부르는 아이디
    private var prjctId = 0
    private var timer:Timer?
    
    
    //MARK: - -------------Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tbList.delegate = self
        tbList.dataSource = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(textViewMoveUp), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(textViewMoveDown), name: UIResponder.keyboardWillHideNotification, object: nil)

    }
    
    
    //MARK: - -------------FUNC
    func showTalkView(prjctObjId:Int , prjctId:Int){
        
        self.prjctObjId = prjctObjId
        self.prjctId = prjctId
        self.view.isHidden = false
        
        self.loadMsgListData()
        
        self.timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true, block: {(timer) in
            if self.arrResult.count > 0{
                self.loadMsgListData(objMsgId: String(self.arrResult.last?.objMsgId ?? 0))
            }
        })
        
    }
    
    
    func hideTalkView(){
        self.view.isHidden = true
        timer?.invalidate()
    }
    
    ///메시지 리스트 불러오기 ( 최초에는 모두 , 이후에는 마지막 인덱스부터
    private func loadMsgListData(objMsgId:String = ""){
        
        objMsgListViewModel.request(prjctObjId: String(prjctObjId),
                                    objMsgId: objMsgId,
                                    admId: userInfo?.admId ?? "",
                                    prjctId:String(prjctId),
                                    completion: {[weak self] (res) in
                                        
            if res.resultVO.count > 0{
                if objMsgId == ""{
                    self?.arrResult = res.resultVO
                }else{
                    self?.arrResult += res.resultVO
                }
                self?.tbList.reloadData()
                self?.scrollBottom()
            }
            
        }, failed: {(_,_) in
            
        })
    }
    
    ///스크롤 하단으로 이동
    private func scrollBottom(){
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: self.arrResult.count - 1, section: 0)
            self.tbList.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
    
    
    
    @objc func textViewMoveUp(_ notification: NSNotification){
        if self.view.isHidden == false{
            if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                print("ket borad size:\(keyboardSize.height)")
                constBottom.constant = (keyboardSize.height * -1)
                constTop.constant = 0
            }
            scrollBottom()
        }
    }
    
    @objc func textViewMoveDown(_ notification: NSNotification){
        if self.view.isHidden == false{
    //        self.segmentTopLayout.transform = .identity
            print("textViewMoveDown")
            constBottom.constant = 0
            constTop.constant = 50
            scrollBottom()
        }
    }

    
    //MARK: - -------------IBAction
    
    @IBAction func actionKeyboardDown(_ sender: Any) {
        tfMessage.resignFirstResponder()
    }
    
    @IBAction func actionBack(_ sender: Any) {
//        navigationController?.popViewController(animated: true)
        hideTalkView()
    }
    
    @IBAction func actionSend(_ sender: Any) {
        
        objMsgInsViewModel.request(prjctObjId: String(prjctObjId),
                                   msgCn: tfMessage.text ?? "내용 없음",
                                   regId: userInfo?.admId ?? "id없음",
                                   prjctId: String(prjctId),
                                   completion: {[weak self](res) in
                                    
                                    self?.tfMessage.text = ""
                                    
                                    //추가 로드
                                    if (self?.arrResult.count ?? 0) > 0{
                                        self?.loadMsgListData(objMsgId: String(self?.arrResult.last?.objMsgId ?? 0))
                                    }

                                    
        }, failed: {(_,_) in
            
        })
        
    }
    
}
//MARK: - -------------UITableView
extension MessageViewController:UITableViewDelegate , UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var identifier = ""
        if arrResult[indexPath.row].regAdmId == userInfo?.admId{
            identifier = "my"
        }else{
            identifier = "your"
        }

        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? MessageCell else {
            return UITableViewCell()
        }
        
        cell.dateView.isHidden = true
        cell.lbContens.text = arrResult[indexPath.row].msgCn
        cell.lbName?.text = arrResult[indexPath.row].regAdmNm
        cell.lbTime.text = arrResult[indexPath.row].regDttm.toTime()
        
        return cell
    }
    
    
}
