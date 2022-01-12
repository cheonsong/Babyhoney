////
////  APIManager.swift
////  Babyhoney
////
////  Created by yeoboya_211221_03 on 2022/01/12.
////
//
import Foundation
import Alamofire
import SwiftyJSON
// TODO: - APIManager
class StoryApiManager: StoryApiService {
    var apiServiceProvider: ApiService?
    
    init(service: ApiService) {
        self.apiServiceProvider = service
    }
    
    func postStoryToBJ(_ story: String ,completion: (() -> Void)?) {
        
        let parameters: [String: Any]? = [ "send_mem_gender": "F",
                                           "send_mem_no": 4521,
                                           "send_chat_name": "천송",
                                           "send_mem_photo": "",
                                           "story_conts": story,
                                           "bj_id": "cheonsong"]
        
        self.apiServiceProvider?.requestApi(url: "http://babyhoney.kr/api/story", method: .post, parameters: parameters, completion: { data in
            // data는 Any 타입이므로 이를 사용하기 위해 다운캐스팅 진행
            let response = data as? DataResponse<Any, AFError>
            
            switch (response?.result) {
            case .success:
                print("POST 성공")
            case .failure(let err):
                print("🚫 Alamofire Request Error\nCode:\(err._code), Message: \(err.errorDescription!)")
            default:
                print("default")
            }
            
        })
    }
    
    func getStoryList(completion: (([Story]) -> Void)?) {
        
        self.apiServiceProvider?.requestApi(url: "http://babyhoney.kr/api/story/page/1?bj_id=cheonsong", method: .get, parameters: nil, completion: { data in
            
            // data는 Any 타입이므로 이를 사용하기 위해 다운캐스팅 진행
            let response = data as? DataResponse<Any, AFError>
            var storyList = [Story]()
            
            switch (response?.result) {
            case .success(let res):
                // 데이터 파싱
                let json = JSON(res)
                json["list"].forEach {
                    let story = Story()
                    story.story = $0.1["story_conts"].stringValue
                    story.gender = $0.1["send_mem_gender"].stringValue
                    story.nickName = $0.1["send_chat_name"].stringValue
                    story.photo = $0.1["send_mem_photo"].stringValue
                    story.bjId = $0.1["bj_id"].stringValue
                    story.time = $0.1["ins_date"].stringValue
                    story.regNo = $0.1["reg_no"].stringValue
                    
                    storyList.append(story)
                }
                
                print("사연 리스트 불러오기 성공")
            case .failure(let err):
                print("🚫 Alamofire Request Error\nCode:\(err._code), Message: \(err.errorDescription!)")
            default:
                print("default")
            }
            completion?(storyList)
        })
    }
    
}
