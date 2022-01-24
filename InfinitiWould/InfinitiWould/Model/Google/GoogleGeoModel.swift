//
//  GoogleGeoModel.swift
//  PositionSharing
//
//  Created by DroneOrange on 2021/04/30.
//

import UIKit

class GoogleGeoRes:Codable
{
    let results:[GoogleGeoItem]
    let status:String
}

class GoogleGeoItem:Codable
{
    let formatted_address:String
    let address_components:[GeoAddressItem]
    let geometry:GeometryItem
}

class GeoAddressItem:Codable
{
    let long_name:String
    let short_name:String
}

class GeometryItem:Codable
{
    let location:LocationItem
}

class LocationItem:Codable
{
    let lat:Double
    let lng:Double
}

class GoogleGeoModel{
    func request(keyword:String, completion: @escaping (GoogleGeoRes) -> Void , failed: @escaping (Int?) -> Void){
        API.url = "https://maps.googleapis.com/maps/api/geocode/json"
        API.method = .get
        API.param = [
            "address":keyword,
            "key":"AIzaSyBIBv2NSaXOucmqnItW7y7wpQXKH0MoNJE"
        ]
        API.method = .get
        API.requestAPI(GoogleGeoRes.self , completion: {(res) in
            print(res)
            completion(res)
        } , failed: {(code) in
            failed(code)
        })
    }
}
