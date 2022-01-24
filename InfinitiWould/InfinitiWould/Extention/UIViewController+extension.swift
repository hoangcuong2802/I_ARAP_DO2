//
//  UIViewController+extension.swift
//  InfinitiWould
//
//  Created by DroneOrange on 2021/06/01.
//

import UIKit

extension UIViewController
{
    //root 화면이 전환됨.
    func rootView(vc:UIViewController)
    {
        UIApplication.shared.windows.first?.rootViewController = vc
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
    //MARK: - -----ViewController 반환
    
    func getCalibrationController() -> CalibrationController?
    {
        let storyboard = UIStoryboard(name: "Calibration", bundle: nil)
        if let vc = storyboard.instantiateViewController(identifier: "CalibrationController") as? CalibrationController{
            return vc
        }
        return nil
    }
    
    func getChageObjSttController() -> ChageObjSttViewController?
    {
        let storyboard = UIStoryboard(name: "ChageObjStt", bundle: nil)
        if let vc = storyboard.instantiateViewController(identifier: "ChageObjSttViewController") as? ChageObjSttViewController{
            return vc
        }
        return nil
    }
    
    func getMessageController() -> MessageViewController?
    {
        let storyboard = UIStoryboard(name: "Message", bundle: nil)
        if let vc = storyboard.instantiateViewController(identifier: "MessageViewController") as? MessageViewController{
            return vc
        }
        return nil
    }
    
    func getLoginController() -> PortraitNaviController?
    {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        if let vc = storyboard.instantiateViewController(identifier: "navi") as? PortraitNaviController{
            return vc
        }
        return nil
    }
    
    func getFindPasswordController() -> FindPasswordViewController?
    {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        if let vc = storyboard.instantiateViewController(identifier: "FindPasswordViewController") as? FindPasswordViewController{
            return vc
        }
        return nil
    }
    
    func getMainViewController() -> LandNaviController?
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(identifier: "navi") as? LandNaviController{
            return vc
        }
        return nil
    }
    
    func getMapController() -> MapViewController?
    {
        let storyboard = UIStoryboard(name: "Map", bundle: nil)
        if let vc = storyboard.instantiateViewController(identifier: "MapViewController") as? MapViewController{
            return vc
        }
        return nil
    }
    
    func getARController() -> ARViewController?
    {
        let storyboard = UIStoryboard(name: "AR", bundle: nil)
        if let vc = storyboard.instantiateViewController(identifier: "ARViewController") as? ARViewController{
            return vc
        }
        return nil
    }
    
    func getObjListController() -> ObjectListViewController?
    {
        let storyboard = UIStoryboard(name: "ObjectList", bundle: nil)
        if let vc = storyboard.instantiateViewController(identifier: "ObjectListViewController") as? ObjectListViewController{
            return vc
        }
        return nil
    }
}



extension UIViewController
{
    //alert을 내보냄
    func showAlert(title:String, message:String = "" ,btnName:String = "확인" , handler: ((UIAlertAction) -> Void)? = nil)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: btnName, style: UIAlertAction.Style.cancel, handler:handler ))
        self.present(alert, animated: true, completion: nil)
    }
    
    //로딩 시작
    func startLoading(){
        if let navi = self.navigationController{
            
            if let custom = navi as? LandNaviController{
                custom.startAnimating()
            }else if let custom = navi as? PortraitNaviController{
                custom.startAnimating()
            }
            
        }
    }
    
    //로딩 끝
    func stopLoading(){
        if let navi = self.navigationController{
            
            if let custom = navi as? LandNaviController{
                custom.stopAnimating()
            }else if let custom = navi as? PortraitNaviController{
                custom.stopAnimating()
            }
            
        }
    }
}


extension UINavigationController {
//    override open var shouldAutorotate: Bool {
//        return false
//    }
}

