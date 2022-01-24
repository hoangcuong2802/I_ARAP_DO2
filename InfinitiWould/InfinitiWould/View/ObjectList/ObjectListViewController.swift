//
//  ObjectListViewController.swift
//  InfinitiWould
//
//  Created by DroneOrange on 2021/07/13.
//

import UIKit

class ObjectListViewController: UIViewController {

    
    
    @IBOutlet weak var tbList: UITableView!
    private var viewModel = ObjectListViewModel()
    private var objList:[ObjectItem]?
    
    
    var complitionHandlerTalk: ((Int)->Void)?
    
    //MARK: - -------------:Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tbList.dataSource = self
        tbList.delegate = self
    }

    //MARK: - -------------:IBAction
    @IBAction func closeAction(_ sender: Any) {
        self.view.isHidden = true
    }
    
    //MARK: - -------------:FUNC
    func requestAPI(prjctId:String){
        self.startLoading()
        viewModel.request(prjctId: prjctId,
                          userId: userInfo?.admId ?? "",
                          completion: {[weak self](res) in
            self?.stopLoading()
            self?.objList = res.resultVO
            self?.tbList.reloadData()
        }, failed: {[weak self](_,_) in
            self?.stopLoading()
        })
    }
    
}

//MARK: - -------------:TableView
extension ObjectListViewController:UITableViewDelegate , UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return objList?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ObjectCell else {
            return UITableViewCell()
        }
        
        if let obj = objList?[indexPath.row] {
            cell.setData(obj: obj)
            
            cell.btTalk.touchUpInside(completion: {[weak self] (btn) in
                if let closer = self?.complitionHandlerTalk
                {
                    closer(obj.prjctObjId)
                }
            })
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
}
