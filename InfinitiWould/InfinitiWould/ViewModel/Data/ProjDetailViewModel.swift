//
//  ProjDetailViewModel.swift
//  InfinitiWould
//
//  Created by DroneOrange on 2021/08/11.
//

import UIKit

class ProjDetailViewModel{
    let model = ProjDetailModel()
    func request(prjctId:String,
                 completion: @escaping (APIProjDetailRes) -> Void , failed: @escaping (Int,String) -> Void){
        model.request(prjctId: prjctId , completion: completion, failed: failed)
    }
}
