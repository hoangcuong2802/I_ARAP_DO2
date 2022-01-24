//
//  FindPwdViewModel.swift
//  InfinitiWould
//
//  Created by DroneOrange on 2021/06/16.
//

import UIKit

class FindPwdViewModel: NSObject {
    let model = FindPwdModel()
    func request(userId:String, userEmail:String, completion: @escaping (APIFindPwdRes) -> Void , failed: @escaping (Int , String) -> Void){
        model.request(userId: userId, userEmail: userEmail, completion: completion, failed: failed)
    }
}
