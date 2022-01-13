//
//  ViewController.swift
//  Babyhoney
//
//  Created by yeoboya_211221_03 on 2022/01/10.
//

import UIKit
import Alamofire

class SendViewController: UIViewController {
    
    // MARK: - Property
    // 키보드 높이를 저장할 변수
    var keyHeight: CGFloat?
    // 슈퍼뷰의 최초 높이를 저장할 변수
    var viewSize: CGFloat?
    // 사연입력창 placeholder
    let placeholder = "10자 이상 300자 이내로 작성해주세요. "
    // api를 보낼 url
    let url = "http://babyhoney.kr/api/story"
    // parameters
    var parameters: [String: Any]?
    // ApiManager
    var apiManager: StoryApiService?
    
    // MARK: - IBOutlet
    // 사연보내기
    @IBOutlet weak var titleLabel: UILabel!
    // (0/300)
    @IBOutlet weak var remainCountLabel: UILabel!
    // 듣고싶은 신청곡, 전하고싶은~~
    @IBOutlet weak var messageLabel: UILabel!
    // 보내기 버튼
    @IBOutlet weak var sendButton: UIButton!
    // 사연 입력창 상위 뷰
    @IBOutlet weak var textRootView: UIView!
    // 사연 입력창
    @IBOutlet weak var textView: UITextView!
    
    // MARK: - IBAction
    // 사연 입력창 내리기 버튼
    @IBAction func downTextView(_ sender: UIButton) {
        if(self.view.frame.size.height == viewSize!) {
            self.presentingViewController?.dismiss(animated: true, completion: nil)
        } else {
            self.view.endEditing(true)
        }
    }
    
    @IBAction func sendStory(_ sender: UIButton) {
        // API매니저를 통해 비제이에게 사연 전송
        apiManager?.postStoryToBJ(self.textView.text, completion: nil)
        
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.textView.delegate = self
        
        // API매니저 초기화
        apiManager = StoryApiManager(service: APIServiceProvider())
        // Letter Spacing 설정
        setLetterSpacing()
        
        // CornerRadius 설정
        self.textRootView.layer.cornerRadius = 5
        self.sendButton.layer.cornerRadius = self.sendButton.frame.height / 2
        
        // 키보드가 올라왔을 떄를 대비하여 최초의 뷰높이 저장
        viewSize = self.view.frame.size.height
        
        self.sendButton.setGradient(color1: UIColor(red: 133/255, green: 129/255, blue: 255/255, alpha: 1), color2: UIColor(red: 152/255, green: 107/255, blue: 255/255, alpha: 1))
        self.sendButton.layer.sublayers?.first?.isHidden = true
        
        //키보드 알림 등록
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(_:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(_:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
    }
    
    // MARK: - Function
    // 자간 간격 정리 함수
    func setLetterSpacing() {
        titleLabel.kern(spacing: -0.9)
        remainCountLabel.kern(spacing: -0.65)
        messageLabel.kern(spacing: -0.65)
    }
    
    // 사연의 길이를 출력해주는 함수
    func updateRemainCountLabel(count: Int) {
        remainCountLabel.text = "(\(count)/\(300))"
    }
    
}
