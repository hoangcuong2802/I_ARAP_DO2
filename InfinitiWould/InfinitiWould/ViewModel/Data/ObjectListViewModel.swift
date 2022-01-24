//
//  ObjectListViewModel.swift
//  InfinitiWould
//
//  Created by DroneOrange on 2021/07/23.
//

import UIKit

class ObjectListViewModel{
    let model = ObjectListModel()
    func request(prjctId:String, userId:String, completion: @escaping (APIObjListRes) -> Void , failed: @escaping (Int,String) -> Void){
        model.request(prjctId: prjctId, userId: userId, completion: completion, failed: failed)
    }
}
