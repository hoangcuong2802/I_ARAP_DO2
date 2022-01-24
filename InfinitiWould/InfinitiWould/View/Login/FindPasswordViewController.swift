//
//  FindPasswordViewController.swift
//  InfinitiWould
//
//  Created by DroneOrange on 2021/06/01.
//

import UIKit

class FindPasswordViewController: UIViewController {
    
    @IBOutlet weak var tfId: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var lbErrorWord: UILabel!
    
    let viewModel = FindPwdViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        #if DEBUG
        tfId.text = "test2"
        tfEmail.text = "youyoungha.do2@gmail.com"
        #endif
        
        lbErrorWord.text = ""
    }
    
    @IBAction func actionBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func actionSendPwd(_ sender: Any){
        
        if let userID = tfId.text , let email = tfEmail.text{
            self.startLoading()
            viewModel.request(userId: userID, userEmail: email, completion: {[weak self](res) in
                self?.stopLoading()
                self?.showAlert(title: "" , message:"입력하신 이메일로\n비밀번호를 발송하였습니다." ,btnName: "로그인" , handler: {(_) in
                    self?.navigationController?.popViewController(animated: true)
                })
            }, failed: {[weak self](code,message) in
                self?.stopLoading()
                if code == 200{
                    self?.lbErrorWord.text = message
                }
            })
        }
    }
    

}
