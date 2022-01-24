//
//  ObjectListModel.swift
//  InfinitiWould
//
//  Created by DroneOrange on 2021/07/23.
//

import UIKit

class APIObjListRes:Codable{
    let resultVO:[ObjectItem]
    let result:String
    let resultMsg:String
}
class ObjectItem:Codable{
    let prjctObjId:Int
    let prjctId:Int
    let objNm:String
    let objAlt:String
    let objStt:String
    let objDiv:String
    let objCn:String
    let regDttm:String
    let regId:String
    let lng:String
    let lat:String
    let newMsgYn:String
}

class ObjectListModel{
    func request(prjctId:String, userId:String, completion: @escaping (APIObjListRes) -> Void , failed: @escaping (Int , String) -> Void){

        API.url = API_DOMAIN_URL + "/api/objList"
        API.method = .post
        API.param = [
            "prjctId":prjctId,
            "userId":userId
        ]
        API.requestAPI(APIObjListRes.self , completion: {(res) in
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
