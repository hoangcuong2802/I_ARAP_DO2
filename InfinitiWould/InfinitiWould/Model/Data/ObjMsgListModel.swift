//
//  ObjMsgListModel.swift
//  InfinitiWould
//
//  Created by DroneOrange on 2021/07/26.
//

import UIKit

class APIObjMsgListRes:Codable{
    let resultVO:[ObjMsgItem]
    let result:String
    let resultMsg:String
}

class ObjMsgItem:Codable{
    let objMsgId:Int
    let prjctObjId:Int
    let msgCn:String
    let regDttm:String
    let regDiv:String
    let regAdmId:String
    let regAdmNm:String
}



class ObjMsgListModel{
    func request(prjctObjId:String,
                 objMsgId:String,
                 admId:String,
                 prjctId:String,
                 completion: @escaping (APIObjMsgListRes) -> Void , failed: @escaping (Int , String) -> Void){

        API.url = API_DOMAIN_URL + "/api/getObjMsgList"
        API.method = .post
        API.param = [
            "objMsgId":objMsgId,
            "admId":admId,
            "prjctObjId":prjctObjId,
            "prjctId":prjctId
        ]
        API.requestAPI(APIObjMsgListRes.self , completion: {(res) in
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
