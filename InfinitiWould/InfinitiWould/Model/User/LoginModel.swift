//
//  LoginModel.swift
//  InfinitiWould
//
//  Created by DroneOrange on 2021/06/15.
//

import UIKit

class APIUserLoginRes:Codable{
    let result:String
    let resultMsg:String
    let loginVO:LoginVO?
}

class  LoginVO: Codable {
    let addr:String?
    let dtlAddr:String?
    let postNum:String?
    let sexdstn:String?
    let useYn:String?
    let userBrthdy:String?
    let userEmail:String?
    let userId:String?
    let userNm:String?
}

class LoginModel{
    
    func request(userId:String, pwd:String, completion: @escaping (APIUserLoginRes) -> Void , failed: @escaping (Int , String) -> Void){
        API.url = API_DOMAIN_URL + "/api/userLogin"
        API.method = .post
        API.param = [
            "userId":userId,
            "pwd":pwd
        ]
        API.requestAPI(APIUserLoginRes.self , completion: {(res) in
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
