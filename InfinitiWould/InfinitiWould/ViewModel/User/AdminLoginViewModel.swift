//
//  AdminLoginViewModel.swift
//  InfinitiWould
//
//  Created by DroneOrange on 2021/07/12.
//

import UIKit

class AdminLoginViewModel {
    
    let model = AdminLoginModel()
    func request(userId:String, pwd:String, completion: @escaping (APIAdminLoginRes) -> Void , failed: @escaping (Int,String) -> Void){
        model.request(userId: userId, pwd: pwd, completion: completion, failed: failed)
    }

}
