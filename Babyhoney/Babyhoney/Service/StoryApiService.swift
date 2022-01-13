//
//  StoryApiService.swift
//  Babyhoney
//
//  Created by yeoboya_211221_03 on 2022/01/12.
//

import Foundation
import Alamofire

protocol StoryApiService {
    // 사연 리스트 GET
    func getStoryList(_ page: Int, completion: ((Int, Int, [Story]) ->Void)?)
    
    // 사연 보내기 POST
    func postStoryToBJ(_ story: String, completion: (() -> Void)?)
    
    // 사연 삭제 DELETE
//    func deleteStory(_ regNo: String, _ bjId: String, completion: (() -> Void)?)
}
