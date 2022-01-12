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
    
    // MARK: - Property
    //    var apiManager: ApiManager?
    var list = [Story]()
    var url = "http://babyhoney.kr/api/story/page/1?bj_id=cheonsong"
    
    // MARK: - IBOutlet
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var middleView: UIView!
    
    // MARK: - IBAction
    @IBAction func tapListDownButton(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tapMoreButton(_ sender: UIButton) {
        let alert = UIAlertController(title: "정말 삭제하시겠습니까?", message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "예", style: .default, handler: { _ in
            // 선택된 위치를 통해 몇번째 셀인지 유추
            let point = sender.convert(CGPoint.zero, to: self.tableView)
            guard let indexPath = self.tableView.indexPathForRow(at: point) else { return }
            let story = self.list[indexPath.row]
            // TODO: - API 요청해서 삭제하기 추가
            // 해당 셀을 리스트, 테이블뷰에서 삭제
            self.list.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            
            // 리스트가 비었다면 등록된 사연이 없습니다. 출력
            if (self.list.isEmpty) {
                self.middleView.isHidden = false
            }
        }))
        
        alert.addAction(UIAlertAction(title: "아니오", style: .default, handler: nil))
        
        self.present(alert, animated: false)
        
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        self.apiManager = ApiManager(service: APIServiceProvider())
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.rowHeight = UITableView.automaticDimension
        
        self.middleView.isHidden = true
        // TODO: - APIManager 리팩토링
        //        apiManager?.getStoryList { data in
        //            data.forEach{ [weak self] story in
        //                self?.list.append(story)
        //            }
        //            self.tableView?.reloadData()
        //        }
        
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
                    story.regNo = $0.1["reg_no"].stringValue
                    
                    print(story.story!)
                    
                    self.list.append(story)
                }
                self.tableView.reloadData()
                
                if self.list.isEmpty {
                    self.middleView.isHidden = false
                }
                
            case .failure(let err):
                print("🚫 Alamofire Request Error\nCode:\(err._code), Message: \(err.errorDescription!)")
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        topView.layer.addBorder([.bottom], color: UIColor(red: 221/255, green: 221/255, blue: 221/255, alpha: 1), width: 1)
    }
}


