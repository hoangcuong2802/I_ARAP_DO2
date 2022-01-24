//
//  LoginViewModel.swift
//  InfinitiWould
//
//  Created by DroneOrange on 2021/06/16.
//

import UIKit

class LoginViewModel{
    let model = LoginModel()
    func request(userId:String, pwd:String, completion: @escaping (APIUserLoginRes) -> Void , failed: @escaping (Int,String) -> Void){
        model.request(userId: userId, pwd: pwd, completion: completion, failed: failed)
    }
}
