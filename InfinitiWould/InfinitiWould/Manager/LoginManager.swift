//
//  LoginManager.swift
//  InfinitiWould
//
//  Created by DroneOrange on 2021/06/15.
//

import UIKit

let Login = LoginManager.shard

class LoginManager{
    
    let viewModel = AdminLoginViewModel()
    static let shard = LoginManager()
    
    func tryLogin(userId:String , pwd:String , completion: @escaping (APIAdminLoginRes) -> Void , failed: @escaping (Int, String) -> Void){
        
        viewModel.request(userId: userId, pwd: pwd, completion: {(res) in
            userInfo = res.loginVO
            completion(res)
        }, failed: {(code , message) in
            failed(code ,  message)
        })
    }
}
