//
//  PortraitNaviController.swift
//  InfinitiWould
//
//  Created by DroneOrange on 2021/06/02.
//

import UIKit
import NVActivityIndicatorView
class PortraitNaviController: UINavigationController {

    var loadingView:NVActivityIndicatorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadingView = NVActivityIndicatorView(frame: self.view.frame, type: .ballRotateChase, color: .systemRed , padding:0)
        if let loadView = loadingView{
            self.view.addSubview(loadView)
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let loadView = loadingView{
//            loadView.frame = CGRect(x: UIScreen.main.bounds.width / 2 - 150 / 2, y: UIScreen.main.bounds.height / 2 - 150 / 2, width: 150, height: 150)
            loadView.translatesAutoresizingMaskIntoConstraints = false
            loadView.centerXAnchor.constraint(equalTo:view.centerXAnchor).isActive = true // ---- 1
            loadView.centerYAnchor.constraint(equalTo:view.centerYAnchor).isActive = true // ---- 2
            loadView.heightAnchor.constraint(equalToConstant: 150).isActive = true // ---- 3
            loadView.widthAnchor.constraint(equalToConstant: 150).isActive = true // ---- 4
        }

    }
    
    func startAnimating(){
        loadingView?.startAnimating()
    }
    func stopAnimating(){
        loadingView?.stopAnimating()
    }

    override open var shouldAutorotate: Bool {
        return true
    }
  
    override open var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

}
