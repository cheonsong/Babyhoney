//
//  APIServiceProvider.swift
//  Babyhoney
//
//  Created by yeoboya_211221_03 on 2022/01/12.
//

import Foundation
import Alamofire
import SwiftyJSON

class APIServiceProvider: ApiService {
    
    func requestApi(url: String, method: HTTPMethod, parameters: [String : Any]?, completion: ((_ response: Any?) ->Void)?) {
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = method.rawValue
        if (method == .post) {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters as Any, options: [])
            } catch {
                print("🚫 http Body Error")
            }
        }
            AF.request(request).responseJSON(completionHandler: completion!)
            
        }
    }
