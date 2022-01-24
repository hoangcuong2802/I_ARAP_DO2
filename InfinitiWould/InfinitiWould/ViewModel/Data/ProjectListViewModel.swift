//
//  ProjectListViewModel.swift
//  InfinitiWould
//
//  Created by DroneOrange on 2021/07/12.
//

import UIKit

class ProjectListViewModel{
    
    let model = ProjectListModel()
    func request(userId:String, completion: @escaping (APIProjectListRes) -> Void , failed: @escaping (Int,String) -> Void){
        model.request(userId: userId, completion: completion, failed: failed)
    }
}
