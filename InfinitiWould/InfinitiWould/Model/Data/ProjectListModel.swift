//
//  ProjectList.swift
//  InfinitiWould
//
//  Created by DroneOrange on 2021/07/12.
//

import UIKit


class APIProjectListRes: Codable {
    let result:String
    let resultMsg:String
    let prjctList1:[ProjectListItem]
    let prjctList2:[ProjectListItem]
    let prjctList3:[ProjectListItem]
    let prjctList4:[ProjectListItem]
}

class ProjectListItem: Codable {
    let prjctId:Int
    let prjctNm:String
    let newMsgYn:String
    let prjctStartDt:String?
    let prjctEndDt:String?
    let addr:String?
}


class ProjectListModel
{
    func request(userId:String, completion: @escaping (APIProjectListRes) -> Void , failed: @escaping (Int , String) -> Void){

        API.url = API_DOMAIN_URL + "/api/prjctList"
        API.method = .post
        API.param = [
            "userId":userId
        ]
        API.requestAPI(APIProjectListRes.self , completion: {(res) in
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
