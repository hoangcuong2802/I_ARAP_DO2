//
//  MapViewController.swift
//  InfinitiWould
//
//  Created by DroneOrange on 2021/06/02.
//

import UIKit
import MapKit
import GoogleMaps


class MapViewController: UIViewController {

    @IBOutlet weak var mk: MKMapView!
    @IBOutlet weak var lbAddr: UILabel!
    
    let tapRecForMapView = UITapGestureRecognizer()

    @IBOutlet weak var mapView: GMSMapView!

    
    //MARK: - ----------Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        mk.delegate = self
    }
    
    //MARK: - ----------FUNC
    func setData(obj:GoogleGeoRes , addr:String){
        
        lbAddr.text = addr
        
        if obj.results.count > 0{
            let lat:Double = obj.results[0].geometry.location.lat
            let lon:Double = obj.results[0].geometry.location.lng

            mapView.isMyLocationEnabled = true
            mapView.isHidden = false
            mapView.camera = GMSCameraPosition.camera(withLatitude: lat, longitude: lon, zoom: 18)
            mapView.isMyLocationEnabled = true
            let urls: GMSTileURLConstructor = { (x, y, zoom) in
                let newY = Int(pow(2, Double(zoom))) - Int(y) - 1

                let url = "http://test.do2.kr/storage/tiles/ydong/\(zoom)/\(x)/\(abs(newY)).png"
                print(url)
              return URL(string: url)
            }
            
            let layer = GMSURLTileLayer(urlConstructor: urls)
            layer.zIndex = 100
            layer.map = mapView
            
//            let marker = GMSMarker()
//            marker.position = CLLocationCoordinate2D(latitude: 33.453541980667566, longitude: 126.57209128978184)
//            marker.title = "맨홀1"
//            marker.snippet = "정합기준1마커"
//            marker.map = mapView

        }else{

            ///오브젝트 목록이 없습니다!
        }
    }
    
    func showMap(temp : String, IsBaseLayer : Bool, clearOverlays : Bool, tileSize : Int) {
        print("********* \(#function) **********")
        if clearOverlays {
            let overlays = mk.overlays
            mk.removeOverlays(overlays)
        }
        
        var overlay : MKTileOverlay? = nil
        
        do {
            overlay = try MKTileOverlay(urlTemplate: temp)
            print("Init of CachedTileOverlay succeeded")
        } catch {
            print("Init of CachedTileOverlay failed with unknown error")
            overlay = MKTileOverlay(urlTemplate: temp)
        }
        
        overlay!.canReplaceMapContent = IsBaseLayer
        mk.addOverlay(overlay!)
    }
    
    //MARK: - ----------IBAction

    @IBAction func actionClose(_ sender: Any) {
        self.view.isHidden = true
    }
}

//MARK: - --------MapKit delegate
extension MapViewController:MKMapViewDelegate, CLLocationManagerDelegate
{
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        print("********* \(#function) **********")
        guard let tileOverlay = overlay as? MKTileOverlay else {
            return MKOverlayRenderer(overlay: overlay)
        }
        return MKTileOverlayRenderer(tileOverlay: tileOverlay)
    }
    
    func mapView(_ mapView: MKMapView, didAdd renderers: [MKOverlayRenderer]) {
        
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, didChange newState: MKAnnotationView.DragState, fromOldState oldState: MKAnnotationView.DragState){
    }
    
    func mapViewDidFinishRenderingMap(_ mapView: MKMapView, fullyRendered: Bool) {
        
    }
    func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) {
        
    }
}

//MARK: - --------GMS MAp
extension MapViewController:GMSMapViewDelegate
{
    func mapViewDidStartTileRendering(_ mapView: GMSMapView) {
        
    }
    
    func mapViewDidFinishLoadingMap(_ mapView: GMSMapView) {
        
    }
    
    func mapViewDidFinishTileRendering(_ mapView: GMSMapView) {
        
    }
        
}
