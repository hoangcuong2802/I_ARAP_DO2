//
//  ChageObjSttViewController.swift
//  InfinitiWould
//
//  Created by DroneOrange on 2021/08/24.
//

import UIKit

class ChageObjSttViewController: UIViewController {

    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbSubTitle: UILabel!
    @IBOutlet weak var btStt: UIButton!
    @IBOutlet weak var txtView: UITextView!
    
    private let viewModel = ChangeObjSttViewModel()
    private var OBJSTT = "OBJSTT100"
    private var item:locationItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK: - ----------IBAction

    @IBAction func actionClose(_ sender: Any) {
        self.view.isHidden = true
    }
    
    func setData(item:locationItem? = nil){
        if let item = item{
            
            self.OBJSTT = item.objStt ?? "OBJSTT100"
            btStt.setTitle(self.OBJSTT.toStatus(), for: .normal)
            self.item = item
            lbTitle.text = item.objCn
            lbSubTitle.text = item.objCn
            txtView.text = item.objCn
            
            self.view.isHidden = false
        }
    }

    
    @IBAction func actionChageStt(_ sender: Any) {
        
        if let bt = sender as? UIButton{
            let alert = UIAlertController(title: "상태 변경", message: "", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "작업대기", style: UIAlertAction.Style.default, handler:{(_) in
                self.OBJSTT = "OBJSTT100"
                bt.setTitle("작업대기", for: .normal)
            }))
            alert.addAction(UIAlertAction(title: "작업중", style: UIAlertAction.Style.default, handler:{(_) in
                self.OBJSTT = "OBJSTT200"
                bt.setTitle("작업중", for: .normal)
            }))
            alert.addAction(UIAlertAction(title: "중지", style: UIAlertAction.Style.default, handler:{(_) in
                self.OBJSTT = "OBJSTT300"
                bt.setTitle("중지", for: .normal)
            }))
            alert.addAction(UIAlertAction(title: "완료", style: UIAlertAction.Style.default, handler:{(_) in
                self.OBJSTT = "OBJSTT400"
                bt.setTitle("완료", for: .normal)
            }))
            
            self.present(alert, animated: true, completion: nil)

        }
        
    }
    
    
    @IBAction func actionSave(_ sender: Any) {
        if let item = self.item{
            viewModel.request(prjctObjId:String(item.prjctObjId ?? 0),
                              objStt: self.OBJSTT, objCn: txtView.text, completion: {(res) in
                                self.showAlert(title: "저장되었습니다." , handler: {(_) in
                                    self.view.isHidden = true
                                })
                              }, failed: {_,_ in
                                
                              })
        }
    }
}
