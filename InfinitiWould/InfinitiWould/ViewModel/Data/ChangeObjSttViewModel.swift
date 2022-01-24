//
//  ChangeObjSttViewModel.swift
//  InfinitiWould
//
//  Created by DroneOrange on 2021/08/24.
//

import UIKit

class ChangeObjSttViewModel {
    let model = ChangeObjSttModel()
    func request(prjctObjId:String,
                 objStt:String,
                 objCn:String,
                 completion: @escaping (APIChangeObjSttRes) -> Void , failed: @escaping (Int,String) -> Void){
        model.request(prjctObjId: prjctObjId ,objStt: objStt , objCn: objCn , completion: completion, failed: failed)
    }
}
