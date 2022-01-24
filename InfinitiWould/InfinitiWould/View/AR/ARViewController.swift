//
//  ARViewController.swift
//  InfinitiWould
//
//  Created by DroneOrange on 2021/07/13.
//

import UIKit
import ARKit
import SceneKit



class GetLocationModel:Codable {
    var result = "N"
    var elevation:Double?
    var resultList:[locationItem]?
}

class locationItem:Codable
{
    var prjctObjId:Int?
    var objDiv = ""
    var lon = ""
    var lat = ""
    var objAlt = ""
    var arPointX:String?
    var arPointY:String?
    var objCn:String?
    var objStt:String?
    
}

//enum ObjStt:String {
//    case wait = "OBJSTT100",
//    case working = "OBJSTT200",
//    case puase = "OBJSTT300",
//    case complete = "OBJSTT400"
//}



class ARViewController: UIViewController {
    var prjctId:String = "" ///전뷰에서 받아올 변수
    
    @IBOutlet var sceneView: ARSCNView!
    
    private var arrPosition = [SCNVector3]()

    private var objListView:ObjectListViewController!
    private var talkView:MessageViewController!
    private var caliView:CalibrationController!
    private var chageObjSttView:ChageObjSttViewController!
    
    private let projDetailViewModel = ProjDetailViewModel()
    
    var resultList = [locationItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ///오브젝트 리스트 뷰
        objListView = self.getObjListController()
        self.addChild(objListView)
        self.view.addSubview(objListView.view)
        objListView.view.isHidden = true
        objListView.complitionHandlerTalk = ({ [weak self] (prjctObjId) in
            self?.talkView.showTalkView(prjctObjId:prjctObjId ,prjctId: Int(self?.prjctId ?? "0") ?? 0)
        })
            
        ///메신져 뷰
        talkView = getMessageController()
        self.addChild(talkView)
        self.view.addSubview(talkView.view)
        talkView.view.isHidden = true
        
        ///오브젝트 수정
        chageObjSttView = getChageObjSttController()
        self.addChild(chageObjSttView)
        self.view.addSubview(chageObjSttView.view)
        chageObjSttView.view.isHidden = true
        
        
        ///켈리브레이션 뷰
        caliView = getCalibrationController()
        self.addChild(caliView)
        self.view.addSubview(caliView.view)
        caliView.view.isHidden = true

        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(rec:)))
        sceneView.addGestureRecognizer(tap)
        
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        sceneView.delegate = self
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = .horizontal
//        config.detectionImages = detectionImages
//        config.maximumNumberOfTrackedImages = 1
        config.isLightEstimationEnabled = true
        config.isAutoFocusEnabled = true
        
        sceneView.autoenablesDefaultLighting   = true
        sceneView.automaticallyUpdatesLighting = true
        
//        sceneView.autoenablesDefaultLighting = true
        sceneView.session.run(config, options: [.resetTracking, .removeExistingAnchors])
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        if let touch = touches.first {
            let touchLocation = touch.location(in: sceneView)
//            let results = sceneView.hitTest(touchLocation, types: .estimatedVerticalPlane)
            let results = sceneView.hitTest(touchLocation, types: .existingPlaneUsingExtent)
            if !results.isEmpty {
                print("touched the plane")
            } else {
                print("touched somewhere else")
                return
            }

            if let hitResult = results.first {

                let posi = SCNVector3(hitResult.worldTransform.columns.3.x,hitResult.worldTransform.columns.3.y,hitResult.worldTransform.columns.3.z)
                if arrPosition.count < 3{
                    arrPosition.append(posi)
                    
                    let BoxGeometry = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0.05)
                    let occlusionMaterial = SCNMaterial()
                    occlusionMaterial.diffuse.contents = UIColor.systemYellow
                    BoxGeometry.materials = [occlusionMaterial]
                    let node = SCNNode(geometry: BoxGeometry)
                    node.renderingOrder = 1
                    node.scale = SCNVector3(1,1,1)
                    node.position = posi
                    sceneView.scene.rootNode.addChildNode(node)
                    
                    if arrPosition.count == 3{

//                        let alert = UIAlertController(title: "위치정합 하시겠습니까?", message: "", preferredStyle: UIAlertController.Style.alert)
//                        alert.addAction(UIAlertAction(title: "정합하기", style: UIAlertAction.Style.destructive, handler: {_ in
//                            self.requestThreeAPI()
//                        }))
//                        alert.addAction(UIAlertAction(title: "취소", style: UIAlertAction.Style.cancel, handler: nil))
//                        self.present(alert, animated: true, completion: nil)
//                        self.showAlert(title: "위치정합 하시겠습니까?" , message:"" ,btnName: "정합하기" , handler: {(_) in
//                            self.requestThreeAPI()
//                        })
                        self.requestThreeAPI()
                    }
                }
                
                
            }
        }
    }

    @objc func handleTap(rec: UITapGestureRecognizer){
        
           if rec.state == .ended {
                let location: CGPoint = rec.location(in: sceneView)
                let hits = self.sceneView.hitTest(location, options: nil)
                if !hits.isEmpty{
                    let tappedNode = hits.first?.node
                    let nodeId = tappedNode?.name ?? ""
                    
                    let list = resultList.filter({String($0.prjctObjId ?? 0) == nodeId})
                    if list.count > 0{
                        let obj = list.first
                        chageObjSttView.setData(item: obj)
                    }else{
                        chageObjSttView.setData()
                    }
                    

                    
                    
                    
                }
           }
    }
    
    
    func requestThreeAPI(){
        
        if arrPosition.count != 3{
            return
        }
        
        
        API.method = .post
        API.param = [
            "prjctId":prjctId,
            "sLat":"33.45336391228791",
            "sLon":"126.57193878267081",
            "pointX1":String(arrPosition[0].x + 10000),
            "pointY1":String(arrPosition[0].z + 10000),
            "pointX2":String(arrPosition[1].x + 10000),
            "pointY2":String(arrPosition[1].z + 10000),
            "pointX3":String(arrPosition[2].x + 10000),
            "pointY3":String(arrPosition[2].z + 10000)
        ]
        API.url = API_DOMAIN_URL + "/api/calibThree"
        API.requestAPI(GetLocationModel.self, completion: {[weak self](result) in
            
            
            
                
            
            
            
            result.resultList?.forEach({ (obj) in
                let BoxGeometry = SCNBox(width: 0.5, height: 0.5, length: 0.5, chamferRadius: 0)
                let occlusionMaterial = SCNMaterial()
                
                occlusionMaterial.diffuse.contents = obj.objStt?.toStatusColor()
//                occlusionMaterial.diffuse.contents = UIColor.systemRed
                BoxGeometry.materials = [occlusionMaterial]
                
                let cube = SCNNode(geometry: BoxGeometry)
                cube.renderingOrder = 1
                cube.position = SCNVector3(Float(obj.arPointX ?? "0") ?? 0,
                                           0,
                                           Float(obj.arPointY ?? "0") ?? 0)
                print("ttttteeeesssstttt")
                cube.scale = SCNVector3(1,1,1)
                cube.name = String(obj.prjctObjId ?? 0)
                self?.sceneView.scene.rootNode.addChildNode(cube)
                self?.resultList.append(obj)
                
            })
        }, failed: {(_) in
            
        })
        
    }
    
    
    
    @IBAction func actionObjectList(_ sender: Any) {
        objListView.requestAPI(prjctId: prjctId)
        objListView.view.isHidden = false
    }
    
    @IBAction func actionCaliView(_ sender: Any) {
        
        projDetailViewModel.request(prjctId: prjctId, completion: { [weak self]res in
            self?.caliView.setMarker(stdrLcList: res.resultVO.stdrLcList)
            self?.caliView.show(addr: res.resultVO.addr)
        }, failed: {_,_ in
            
        })
    }
    
    
    @IBAction func actionClose(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
}


