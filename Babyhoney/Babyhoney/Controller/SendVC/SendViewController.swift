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
    
    var keyHeight: CGFloat?     // 키보드 높이를 저장할 변수
    let placeholder = "10자 이상 300자 이내로 작성해주세요. "    // 사연입력창 placeholder
    var apiManager: StoryApiService?    // ApiManager
    let colorManager = CustomColor()    // ColorManger
    var editFlag: Bool = false     // 사연이 입력중인지 아닌지를 판단하는 플래그 (빈공간 터치시 키보드, 화면을 제어하기 위한 변수)
    var backgroundView: UIView?
    
    // MARK: - IBOutlet
    @IBOutlet weak var remainCountLabel: UILabel!   // (0/300)
    @IBOutlet weak var sendButton: UIButton!        // 보내기 버튼
    @IBOutlet weak var textRootView: UIView!        // 사연 입력창 상위 뷰
    @IBOutlet weak var textView: UITextView!        // 사연 입력창
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!    // 키보드가 올라왔을 때 화면을 조정하기 위한 레이아웃
    @IBOutlet weak var storySendView: UIView!
    
    // MARK: - IBAction
    // 사연 입력창 내리기 버튼
    @IBAction func downTextView(_ sender: UIButton) {
        // 텍스트뷰를 편집중이지 않은경우 이전 화면으로
        if(!editFlag) {
            self.presentingViewController?.dismiss(animated: true, completion: nil)
        } else {
            // 텍스트뷰 편집 시 편집 종료, 키보드 내림
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
        
        // CornerRadius 설정
        self.textRootView.layer.cornerRadius = 5
        self.sendButton.layer.cornerRadius = self.sendButton.frame.height / 2
        
        self.sendButton.setGradient(color1: colorManager.gradientStartColor, color2: colorManager.gradientFinishColor)
        self.sendButton.layer.sublayers?.first?.isHidden = true
        
        backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height - self.storySendView.frame.size.height))
        backgroundView?.backgroundColor = .black
        self.view.insertSubview(backgroundView!, at: 0)
        
        //키보드 알림 등록
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(adjustInputView),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(adjustInputView),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
    }
    
    deinit {
        print("SendVC deinit")
    }
    
    // MARK: - Function
    // 사연의 길이를 출력해주는 함수
    func updateRemainCountLabel(count: Int) {
        remainCountLabel.text = "(\(count)/\(300))"
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
    }
    
}
