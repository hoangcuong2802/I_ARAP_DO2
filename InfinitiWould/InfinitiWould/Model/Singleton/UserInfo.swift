//
//  UserInfo.swift
//  InfinitiWould
//
//  Created by DroneOrange on 2021/06/16.
//

import UIKit
var userInfo = UserInfo.shard.userInfo
class UserInfo{
    var userInfo:AdminLoginVo?
    static let shard = UserInfo()
}
