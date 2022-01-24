
import UIKit
import Alamofire
let API = NetworkManager.shard
//let API_DOMAIN_URL = "http://192.168.0.180:8080"
let API_DOMAIN_URL = "http://121.66.138.213:1800"

class NetworkManager{
    
    static let shard = NetworkManager()
    var param:[String:Any] = [:]
    var parameters:Parameters?
    var method:HTTPMethod = .get
    var url:String?
    
    func requestAPI<T:Decodable>(_ resultType:T.Type ,completion: @escaping (T) -> Void , failed: @escaping (Int) -> Void)
    {
        if let strUrl = url
        {
            AF.request(strUrl ,
                       method:self.method ,
                       parameters:param)
            .responseJSON { (data) in
                print(data.result)
            }
            .responseDecodable(of: resultType) { (response) in
                if let result = response.value
                {
                    completion(result)
                }
                else
                {
                    failed(response.response?.statusCode ?? 0)
                }
            }
        }
        else
        {
            failed(0)
        }
    }
}
