//
//  AdminLoginModel.swift
//  InfinitiWould
//
//  Created by DroneOrange on 2021/07/12.
//

import UIKit


class APIAdminLoginRes: Codable {
    let result:String
    let resultMsg:String
    let loginVO:AdminLoginVo?
}

class AdminLoginVo: Codable {
    let admId:String
    let admNm:String?
    let hpNum:String?
    let email:String?
}


class AdminLoginModel{
    
    func request(userId:String, pwd:String, completion: @escaping (APIAdminLoginRes) -> Void , failed: @escaping (Int , String) -> Void){
        API.url = API_DOMAIN_URL + "/api/admLogin"
        API.method = .post
        API.param = [
            "userId":userId,
            "pwd":pwd
        ]
        API.requestAPI(APIAdminLoginRes.self , completion: {(res) in
            print(res)
            if res.result == "Y"{
                completion(res)
            }else{
                failed(200 , res.resultMsg)
            }
            
        } , failed: {(code) in
            failed(code , "")
        })
    }
}
