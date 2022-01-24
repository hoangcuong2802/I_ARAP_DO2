//
//  FindPwdModel.swift
//  InfinitiWould
//
//  Created by DroneOrange on 2021/06/15.
//

import UIKit


class APIFindPwdRes:Codable{
    let result:String
    let resultMsg:String
}

class FindPwdModel{
    func request(userId:String, userEmail:String, completion: @escaping (APIFindPwdRes) -> Void , failed: @escaping (Int , String) -> Void){
        API.url = API_DOMAIN_URL + "/api/findPwd"
        API.method = .post
        API.param = [
            "userId":userId,
            "userEmail":userEmail
        ]
        API.requestAPI(APIFindPwdRes.self , completion: {(res) in
            
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
