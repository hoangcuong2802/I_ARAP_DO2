//
//  MainViewController.swift
//  InfinitiWould
//
//  Created by DroneOrange on 2021/06/01.
//

import UIKit

class MainViewController: UIViewController {

    
    @IBOutlet private weak var tbList: UITableView!
    @IBOutlet private weak var memberView: UIView!
    @IBOutlet private weak var btMy: UIButton!
    @IBOutlet private weak var lbMyName: UILabel!
    @IBOutlet private weak var lbMyEmail: UILabel!
    
    @IBOutlet private weak var lbMyEmailtest: UILabel!
    
    private var mapView:MapViewController!
    
    private var projectListViewModel = ProjectListViewModel()
    
    private var arrWaitProject:[ProjectListItem]?
    private var arrWorkingProject:[ProjectListItem]?
    private var arrPauseProject:[ProjectListItem]?
    private var arrCompleteProject:[ProjectListItem]?
    
    ///리스트 접었다 폈다 할수있도록 상태값 저장
    var selectFlag = [0:true , 1:true , 2:true , 3:true]
    
    
    //MARK: - --------------LIFE CYCLE--------
    override func viewDidLoad() {
        super.viewDidLoad()

        tbList.delegate = self
        tbList.dataSource = self
        
        setDefault()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUI()
    }
    
    //MARK: - --------------FUNC--------
    
    private func setDefault(){
        ///지도 레이어 팝업 화면 애드(최초 1회 애드)
        mapView = getMapController()
        self.addChild(mapView)
        self.view.addSubview(mapView.view)
        mapView.view.isHidden = true

        ///회원 뷰 최초 히든
        memberView.isHidden = true
        
        ///회원 정보 가져와 뿌려줌!
        if let userInfo = userInfo ,
           let firstName = userInfo.admNm?.substring(from: 1, to: 2)
        {
            btMy.setTitle(firstName, for: .normal)
            lbMyName.text = userInfo.admNm
            lbMyEmail.text = userInfo.email
        }
    }
    
    private func setUI(){
        
        if let userId = userInfo?.admId{
            
            projectListViewModel.request(userId: userId, completion: {[weak self](res) in
                self?.arrWaitProject = res.prjctList1
                self?.arrWorkingProject = res.prjctList2
                self?.arrPauseProject = res.prjctList3
                self?.arrCompleteProject = res.prjctList4
                self?.tbList.reloadData()
            }, failed: { (code,msg) in
                
            })
        }
    }
    
    
    //MARK: - --------------IBAction--------
    
    @IBAction func actionMemberView(_ sender: Any) {
        memberView.isHidden = !memberView.isHidden
    }
    
    
    @IBAction func actionLogout(_ sender: Any) {
        
        let alert = UIAlertController(title: "로그아웃 하시겠습니까?", message: "", preferredStyle: UIAlertController.Style.alert)
        // add the actions (buttons)
        alert.addAction(UIAlertAction(title: "로그아웃", style: UIAlertAction.Style.destructive, handler: {_ in
            if let vc = self.getLoginController(){
                self.rootView(vc: vc)
            }
        }))
        alert.addAction(UIAlertAction(title: "취소", style: UIAlertAction.Style.cancel, handler: nil))
        // show the alert
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    @IBAction func actionTest(_ sender: Any) {

    }
    
}

//MARK: - --------------UITableView--------
extension MainViewController:UITableViewDelegate , UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let bt = CustomButton()
        
        switch section {
            case 0:
                bt.setTitle("   대기중인 프로젝트(\(arrWaitProject?.count ?? 0))", for: .normal)
                break
            case 1:
                bt.setTitle("   작업중인 프로젝트(\(arrWorkingProject?.count ?? 0))", for: .normal)
                break
            case 2:
                bt.setTitle("   중지 된 프로젝트(\(arrPauseProject?.count ?? 0))", for: .normal)
                break
            case 3:
                bt.setTitle("   완료 된 프로젝트(\(arrCompleteProject?.count ?? 0))", for: .normal)
                break
            default: break
        }
        bt.setTitleColor(.darkGray, for: .normal)
        bt.setImage(.init(systemName: "arrowtriangle.right.fill"), for: .normal)
        bt.setImage(.init(systemName: "arrowtriangle.down.fill"), for: .selected)
        bt.contentHorizontalAlignment = .left
        bt.tintColor = .darkGray
        bt.contentEdgeInsets = UIEdgeInsets(top: 20,left: 20,bottom: 0,right: 0)
        if let flag = selectFlag[section]{
            bt.isSelected = flag
        }
        bt.touchUpInside(completion: {[weak self] (bt) in
            if bt.isSelected{
                bt.isSelected = false
                self?.selectFlag[section] = false
            }else{
                bt.isSelected = true
                self?.selectFlag[section] = true
            }
            
            
            self?.tbList.beginUpdates()
            self?.tbList.rowHeight = UITableView.automaticDimension
            self?.tbList.endUpdates()
            
        })
        return bt
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        80
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
            case 0: return arrWaitProject?.count ?? 0
            case 1: return arrWorkingProject?.count ?? 0
            case 2: return arrPauseProject?.count ?? 0
            case 3: return arrCompleteProject?.count ?? 0
            default: break
        }
        return 0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let flag = selectFlag[indexPath.section] , flag == true {
            return (indexPath.row == 0) ? 64 : 32
        }
        
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "projectCell", for: indexPath) as? ProjectCell else {
            return UITableViewCell()
        }
        cell.headerView.isHidden = (indexPath.row != 0)
        
        switch indexPath.section {
            case 0:
                cell.setData(obj: arrWaitProject?[indexPath.row])
                break
            case 1:
                cell.setData(obj: arrWorkingProject?[indexPath.row])
                break
            case 2:
                cell.setData(obj: arrPauseProject?[indexPath.row])
                break
            case 3:
                cell.setData(obj: arrCompleteProject?[indexPath.row])
                break
            default: break
        }

        ///프로젝트 이름 관련 버튼 엑션
        cell.btProjName.touchUpInside(completion: {[weak self] (btn) in
            if let vc = self?.getARController(){
                switch indexPath.section {
                    case 0:
                        vc.prjctId = String(self?.arrWaitProject?[indexPath.row].prjctId ?? 0)
                        break
                    case 1:
                        vc.prjctId = String(self?.arrWorkingProject?[indexPath.row].prjctId ?? 0)
                        break
                    case 2:
                        vc.prjctId = String(self?.arrPauseProject?[indexPath.row].prjctId ?? 0)
                        break
                    case 3:
                        vc.prjctId = String(self?.arrCompleteProject?[indexPath.row].prjctId ?? 0)
                        break
                    default: break
                }
                self?.navigationController?.pushViewController(vc, animated: true)
            }
        })
        
        ///주소 관련 버튼 엑션
        cell.btProjAddr.touchUpInside(completion: {[weak self] (btn) in
            
            var addr = ""
            switch indexPath.section {
                case 0:
                    addr = self?.arrWaitProject?[indexPath.row].addr ?? ""
                    break
                case 1:
                    addr = self?.arrWorkingProject?[indexPath.row].addr ?? ""
                    break
                case 2:
                    addr = self?.arrPauseProject?[indexPath.row].addr ?? ""
                    break
                case 3:
                    addr = self?.arrCompleteProject?[indexPath.row].addr ?? ""
                    break
                default: break
            }
            
            if addr == ""{
                return
            }
            
            let model = GoogleGeoModel()
            self?.startLoading()
            model.request(keyword: addr, completion: {[weak self](obj)in
                print("성공")
                self?.stopLoading()
                self?.mapView.setData(obj: obj , addr: addr)
                self?.mapView.view.isHidden = false
            }, failed: {(error) in
                print("실패")
                self?.stopLoading()
            })
        })
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
    
    
}
