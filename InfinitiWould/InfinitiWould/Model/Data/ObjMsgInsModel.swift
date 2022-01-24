//
//  ObjMsgInsModel.swift
//  InfinitiWould
//
//  Created by DroneOrange on 2021/07/27.
//

import UIKit

class APIObjMsgInsRes:Codable{
    let result:String
    let resultMsg:String
}

class ObjMsgInsModel {
    func request(prjctObjId:String,
                 msgCn:String,
                 regId:String,
                 prjctId:String,
                 completion: @escaping (APIObjMsgInsRes) -> Void , failed: @escaping (Int , String) -> Void){

        API.url = API_DOMAIN_URL + "/api/insObjMsg"
        API.method = .post
        API.param = [
            "prjctObjId":prjctObjId,
            "msgCn":msgCn,
            "regId":regId,
            "prjctId":prjctId
        ]
        API.requestAPI(APIObjMsgInsRes.self , completion: {(res) in
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
