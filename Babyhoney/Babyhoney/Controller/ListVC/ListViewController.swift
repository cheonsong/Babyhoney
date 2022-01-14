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
    var apiManager: StoryApiService?    // Api매니저
    var list = [Story]()                // tableview에 출력할 사연리스트
    var page = 1                        // (페이징)사연을 불러왔을 때 현재 페이지
    var lastPage: Int = 0               // (페이징)총 사연 수를 저장할 변수
    var isPaging = false                // 페이징 중을 알려주는 변수
    var hasNextPage = false             // 다음 페이지가 남아있는지 알려주는 변수
    let colorManager = CustomColor()
    var backgroundView: UIView?
    
    // MARK: - IBOutlet
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var topView: UIView!         // 최상단 제목 및 설명 뷰
    @IBOutlet weak var middleView: UIView!      // 사연이 없을경우 출력할 뷰
    @IBOutlet weak var stackView: UIStackView!
    
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
            
            // TODO: - API 요청해서 삭제하기 추가
            // 해당 셀을 리스트, 테이블뷰에서 삭제
            // 선택된 셀을 테이블 뷰, 리스트에서 삭제
            self.list.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            
            //self.apiManager?.deleteStory(story.regNo!, story.bjId!, completion: nil)
            
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
        
        self.apiManager = StoryApiManager(service: APIServiceProvider())
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.backgroundColor = .white
        
        backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height - self.stackView.frame.size.height))
        backgroundView?.backgroundColor = .black
        self.view.insertSubview(backgroundView!, at: 0)
        
        // 다음페이지, 총 페이지, 사연리스트를 받아옴
        apiManager?.getStoryList(page) {nextPage, lastPage, data in
            
            self.page = nextPage
            self.lastPage = lastPage
            
            // API응답받은 사연리스트를 추가하고 테이블뷰 데이터를 리로드 함.
            data.forEach{ [weak self] story in
                self?.list.append(story)
            }
            self.tableView?.reloadData()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // 테이블뷰와 최상단뷰를 구분하기위해 최상단뷰의 아래쪽에 색을 추가함
        topView.layer.addBorder([.bottom], color: colorManager.color238, width: 1)
        
        // 페이징
        paging()
    }
    
    deinit {
        print("ListVC deinit")
    }
    
    // MARK: - Function
    // 스크롤을 끝까지 내렸을 경우 실행하게될 페이징 함수
    func paging() {
        var datas: [Story] = []
        
        // 다음 페이지가 있다면, 다음페이지, 총 페이지, 사연리스트를 받아옴
        if (hasNextPage) {
            apiManager?.getStoryList(page) {nextPage, lastPage, data in
                data.forEach{ [weak self] story in
                    
                    self?.page = nextPage
                    self?.lastPage = lastPage
                    
                    // 받아온 사연 리스트 저장
                    datas.append(story)
                }
            }
        }
        
        // 사연리스트를 불러온 후 실행
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            
            // list가 비어있어도 이미 남아있는 사연들을 불러온 후 list가 업데이트 되지 않은 경우이기 때문에
            // list는 다시 추가될것임 이기에 당장 리스트가 비어있다고 해서 출력할 사연이 없는것이 아님
            // 하지만 지금 시점에서는 list는 비어있고 등록된 사연이 없다는 뷰가 출력되기 때문에 해당뷰를 숨겨줌
            // 이 시점에서 뷰를 숨기지 않으면 테이블뷰가 리로드 돼도 사연이 없다고 출력됨
            if (self.list.isEmpty) {
                self.middleView.isHidden = true
            }
            
            // list에 새로 불러온 사연 추가
            self.list.append(contentsOf: datas)
            
            // 사연이 남아있는지 아닌지 계산 후 저장
            self.hasNextPage = self.lastPage == ((self.page - 2) * 5 + (self.lastPage % 5)) ? false : true
            // 페이징이 끝났으므로 페이징중 변수 false
            self.isPaging = false
            // list에 추가한 데이터를 테이블뷰에 출력
            self.tableView.reloadData()
        }
        
    }
}


