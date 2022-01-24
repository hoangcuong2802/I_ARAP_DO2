//
//  ObjMsgListViewModel.swift
//  InfinitiWould
//
//  Created by DroneOrange on 2021/07/26.
//

import UIKit

class ObjMsgListViewModel {
    let model = ObjMsgListModel()
    func request(prjctObjId:String, objMsgId:String, admId:String, prjctId:String, completion: @escaping (APIObjMsgListRes) -> Void , failed: @escaping (Int,String) -> Void){
        model.request(prjctObjId: prjctObjId , objMsgId:objMsgId , admId: admId, prjctId:prjctId, completion: completion, failed: failed)
    }
}
