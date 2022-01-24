//
//  ObjMsgInsViewModel.swift
//  InfinitiWould
//
//  Created by DroneOrange on 2021/07/27.
//

import UIKit

class ObjMsgInsViewModel {
    let model = ObjMsgInsModel()
    func request(prjctObjId:String,
                 msgCn:String,
                 regId:String,
                 prjctId:String,
                 completion: @escaping (APIObjMsgInsRes) -> Void , failed: @escaping (Int,String) -> Void){
        model.request(prjctObjId: prjctObjId , msgCn:msgCn,regId:regId,prjctId: prjctId, completion: completion, failed: failed)
    }
}
