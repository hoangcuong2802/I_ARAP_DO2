//
//  ProjDetailModel.swift
//  InfinitiWould
//
//  Created by DroneOrange on 2021/08/11.
//

import UIKit

class APIProjDetailRes:Codable{
    let result:String
    let resultMsg:String
    let resultVO:ProjDetailItem
}

class ProjDetailItem: Codable {
    let prjctId:Int
    let prjctNm:String
    let prjctStt:String?
    let prjctStartDt:String
    let prjctEndDt:String
    let addr:String
    let dtlAddr:String?
    let stdrLcList:[StdrLcListItem]?
}

class StdrLcListItem:Codable{
    let stdrLcId:Int
    let prjctId:Int
    let lat:String
    let lng:String
    let stdrLcSn:Int
    var stdrLcDc:String = "이름없음"
}

class ProjDetailModel{
    func request(prjctId:String,
                 completion: @escaping (APIProjDetailRes) -> Void , failed: @escaping (Int , String) -> Void){

        API.url = API_DOMAIN_URL + "/api/dtlPrjct"
        API.method = .post
        API.param = [
            "prjctId":prjctId
        ]
        API.requestAPI(APIProjDetailRes.self , completion: {(res) in
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
