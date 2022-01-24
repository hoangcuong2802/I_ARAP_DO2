//
//  ChangeObjSttModel.swift
//  InfinitiWould
//
//  Created by DroneOrange on 2021/08/24.
//

import UIKit

class APIChangeObjSttRes:Codable{
    let result:String
    let resultMsg:String
}

class ChangeObjSttModel{
    func request(prjctObjId:String,
                 objStt:String,
                 objCn:String,
                 completion: @escaping (APIChangeObjSttRes) -> Void , failed: @escaping (Int , String) -> Void){

        API.url = API_DOMAIN_URL + "/api/changeObjStt"
        API.method = .post
        API.param = [
            "prjctObjId":prjctObjId,
            "objStt":objStt,
            "objCn":objCn
        ]
        API.requestAPI(APIChangeObjSttRes.self , completion: {(res) in
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
