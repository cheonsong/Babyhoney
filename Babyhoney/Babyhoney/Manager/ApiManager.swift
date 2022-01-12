////
////  APIManager.swift
////  Babyhoney
////
////  Created by yeoboya_211221_03 on 2022/01/12.
////
//
//import Foundation
//import Alamofire
//import SwiftyJSON
// TODO: - APIMansger
//class ApiManager: StoryApiService {
//
//    var apiServiceProvider: ApiService?
//
//    init(service: ApiService) {
//        self.apiServiceProvider = service
//    }
//
//    func getStoryList(completion: (([Story]) -> Void)?) {
//
//        self.apiServiceProvider?.requestApi(url: "http://babyhoney.kr/api/story/page/1?bj_id=cheonsong", method: .get, parameters: nil, completion: { data in
//
//            switch (response.result) {
//            case .success(let res):
//                print("사연 리스트 불러오기 성공")
//            case .failure(let err):
//                print("🚫 Alamofire Request Error\nCode:\(err._code), Message: \(err.errorDescription!)")
//            }
//            // StoryModel jsonDecoding
//            let storyList : [Story] = []
//            completion?(storyList)
//        })
//    }
//
//}
