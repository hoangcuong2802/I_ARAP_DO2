//
//  GoogleGeoViewModel.swift
//  InfinitiWould
//
//  Created by DroneOrange on 2021/06/16.
//

import UIKit

class GoogleGeoViewModel: NSObject {
    let model = GoogleGeoModel()
    
    func request(keyword:String, completion: @escaping (GoogleGeoRes) -> Void , failed: @escaping (Int?) -> Void){
        model.request(keyword: keyword, completion: completion, failed: failed)
    }
}
