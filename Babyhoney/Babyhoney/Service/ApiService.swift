//
//  APIService.swift
//  Babyhoney
//
//  Created by yeoboya_211221_03 on 2022/01/11.
//

import Foundation
import Alamofire

protocol ApiService {
    func requestApi(
        url: String,
        method : HTTPMethod,
        parameters: [String: Any]?,
        completion: ((_ response: Any?) ->Void)?
    )
}


