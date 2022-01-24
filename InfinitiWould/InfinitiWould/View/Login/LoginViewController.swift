//
//  LoginViewController.swift
//  InfinitiWould
//
//  Created by DroneOrange on 2021/06/01.
//

import UIKit


class LoginViewController: UIViewController {

    @IBOutlet weak var tfId: UITextField!
    @IBOutlet weak var tfPw: UITextField!
    @IBOutlet weak var lbErrorWord: UILabel!
    
    @IBOutlet weak var btRememberId: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        setDefaultUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIDevice.current.setValue(Int(UIInterfaceOrientation.portrait.rawValue), forKey: "orientation")
    }

    
    private func setDefaultUI(){
        
        #if DEBUG
        tfId.text = "test2"
        tfPw.text = "1"
        #endif
        
        lbErrorWord.text = ""
    }
    
    
    @IBAction func actionLoginTry(_ sender: Any) {
        
//        if let vc = getMainViewController(){
//            rootView(vc: vc)
//        }
        
        if let userID = tfId.text , let pwd = tfPw.text{
            self.startLoading()
            Login.tryLogin(userId: userID, pwd: pwd, completion: {[weak self](_) in

                self?.stopLoading()
                if let vc = self?.getMainViewController(){
                    self?.rootView(vc: vc)
                }

            }, failed: {[weak self](code , message) in
                self?.stopLoading()
                if code == 200{
                    self?.lbErrorWord.text = message
//                    self?.showAlert(title: "" , message:message)
                }
            })
        }
    }
    
    
    @IBAction func actionMoveFindPassword(_ sender: Any) {
        if let vc = self.getFindPasswordController(){
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
