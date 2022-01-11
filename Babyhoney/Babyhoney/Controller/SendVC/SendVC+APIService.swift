//
//  SendVC+APIService.swift
//  Babyhoney
//
//  Created by yeoboya_211221_03 on 2022/01/11.
//

import Foundation
import Alamofire

extension SendViewController: ApiService {
    func requestApi(url: String, method: HTTPMethod, parameters: [String : Any]?, completion: ((Any?) -> Void)?) {
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = method.rawValue
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters as Any, options: [])
        } catch {
            print("🚫 http Body Error")
        }
        
        AF.request(request).responseString { (response) in
            switch response.result {
            case .success:
                print("POST 성공")
            case .failure(let err):
                print("🚫 Alamofire Request Error\nCode:\(err._code), Message: \(err.errorDescription!)")
            }
        }
    }
}
