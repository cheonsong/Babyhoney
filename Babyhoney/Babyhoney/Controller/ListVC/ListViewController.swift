//
//  ListViewController.swift
//  Babyhoney
//
//  Created by yeoboya_211221_03 on 2022/01/11.
//

import UIKit
import Alamofire
import SwiftyJSON

class ListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var list = [Story]()
    var url = "http://babyhoney.kr/api/story/page/1?bj_id=cheonsong"
    
    @IBAction func tapListDownButton(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.rowHeight = UITableView.automaticDimension
        
        AF.request(URLRequest(url: URL(string: url)!)).responseJSON { (response) in
            switch response.result {
            case .success(let res):
                let json = JSON(res)
                
                print(json["list"])
                json["list"].forEach {
                    let story = Story()
                    story.story = $0.1["story_conts"].stringValue
                    story.gender = $0.1["send_mem_gender"].stringValue
                    story.nickName = $0.1["send_chat_name"].stringValue
                    story.photo = $0.1["send_mem_photo"].stringValue
                    story.bjId = $0.1["bj_id"].stringValue
                    story.time = $0.1["ins_date"].stringValue
                    print(story.story!)
                    
                    self.list.append(story)
                }
                self.tableView.reloadData()
                
            case .failure(let err):
                print("🚫 Alamofire Request Error\nCode:\(err._code), Message: \(err.errorDescription!)")
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.estimatedRowHeight = 50
        self.tableView.rowHeight = UITableView.automaticDimension
    }
    
    
    // 바깥 뷰 터치시 이벤트 처리
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if let touch = touches.first , touch.view == self.view {
            self.presentingViewController?.dismiss(animated: true, completion: nil)
        }
    }
}
