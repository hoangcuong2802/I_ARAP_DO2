//
//  CalibrationController.swift
//  InfinitiWould
//
//  Created by DroneOrange on 2021/08/10.
//

import UIKit
import MapKit
import GoogleMaps
class CalibrationController: UIViewController {

    
    @IBOutlet weak var mapView: GMSMapView!

    let marker1 = GMSMarker()
    let marker2 = GMSMarker()
    let marker3 = GMSMarker()
    var arrMarker = [GMSMarker]()
    
    private let model = GoogleGeoModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        arrMarker.append(marker1)
        arrMarker.append(marker2)
        arrMarker.append(marker3)

    }
    
    //MARK: - ----------FUNC
    func setData(obj:GoogleGeoRes , addr:String){

        if obj.results.count > 0{
            let lat:Double = obj.results[0].geometry.location.lat
            let lon:Double = obj.results[0].geometry.location.lng

            mapView.isMyLocationEnabled = true
            mapView.isHidden = false
            mapView.camera = GMSCameraPosition.camera(withLatitude: lat, longitude: lon, zoom: 18)
            
            let urls: GMSTileURLConstructor = { (x, y, zoom) in
                let newY = Int(pow(2, Double(zoom))) - Int(y) - 1

                let url = "http://test.do2.kr/storage/tiles/ydong/\(zoom)/\(x)/\(abs(newY)).png"
                print(url)
              return URL(string: url)
            }
            
            let layer = GMSURLTileLayer(urlConstructor: urls)
            layer.zIndex = 100
            layer.map = mapView
            
            

        }else{

            ///오브젝트 목록이 없습니다!
        }
    }
    
    func setMarker(stdrLcList:[StdrLcListItem]?){
        
        if (stdrLcList?.count ?? 0) == 3{
            let item1 = stdrLcList?[0]
            let item2 = stdrLcList?[1]
            let item3 = stdrLcList?[2]
            
            marker1.position = CLLocationCoordinate2D(latitude: Double(item1?.lat ?? "0") ?? 0, longitude: Double(item1?.lng ?? "0") ?? 0)
            marker1.title = item1?.stdrLcDc ?? ""
            marker1.snippet = "정합기준1마커"
//            marker1.icon = UIImage.init(named: "img_star")!
            marker1.map = mapView
            
            marker2.position = CLLocationCoordinate2D(latitude: Double(item2?.lat ?? "0") ?? 0, longitude: Double(item2?.lng ?? "0") ?? 0)
            marker2.title = item2?.stdrLcDc ?? ""
            marker2.snippet = "정합기준2마커"
            marker2.map = mapView
            
            marker3.position = CLLocationCoordinate2D(latitude: Double(item3?.lat ?? "0") ?? 0, longitude: Double(item3?.lng ?? "0") ?? 0)
            marker3.title = item3?.stdrLcDc ?? ""
            marker3.snippet = "정합기준3마커"
            marker3.map = mapView
        }
    }
    
    func show(addr:String){
        
        self.startLoading()
        model.request(keyword: addr, completion: {[weak self](obj)in
            print("성공")
            self?.stopLoading()
            self?.setData(obj: obj , addr: addr)
            self?.view.isHidden = false
        }, failed: {(error) in
            print("실패")
            self.stopLoading()
        })
    }
    
    
    //MARK: - ----------IBAction

    @IBAction func actionClose(_ sender: Any) {
        self.view.isHidden = true
    }

}

//MARK: - --------GMS MAp
extension CalibrationController:GMSMapViewDelegate
{
    func mapViewDidStartTileRendering(_ mapView: GMSMapView) {
        
    }
    
    func mapViewDidFinishLoadingMap(_ mapView: GMSMapView) {
        
    }
    
    func mapViewDidFinishTileRendering(_ mapView: GMSMapView) {
        
    }
        
}
