//
//  ViewController.swift
//  Babyhoney
//
//  Created by yeoboya_211221_03 on 2022/01/10.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var remainCountLabel: UILabel!
    
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var sendButton: UIButton!
    
    @IBOutlet weak var textRootView: UIView!
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.textView.delegate = self
        
        // Letter Spacing 설정
        setLetterSpacing()
        
        // CornerRadius 설정
        self.textRootView.layer.cornerRadius = 5
        self.sendButton.layer.cornerRadius = self.sendButton.frame.height / 2
    }
    
    func setLetterSpacing() {
        titleLabel.kern(spacing: -0.9)
        remainCountLabel.kern(spacing: -0.65)
        messageLabel.kern(spacing: -0.65)
    }
    
    // 사연의 길이를 출력해주는 함수
    func updateRemainCountLabel(count: Int) {
        remainCountLabel.text = "\(count)/300"
    }
    
}

extension ViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        // 편집이 시작되면 플레이스홀더를 지우고 텍스트컬러를 수정함
        self.textView.text = ""
        self.textView.textColor = UIColor(red: 17/255, green: 17/255, blue: 17/255, alpha: 1)
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = "10자 이상 300자 이내로 작성해주세요."
            textView.textColor = UIColor(red: 102/255, green: 102/255, blue: 102/255, alpha: 1)
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        // 공백, 개행을 카운트하지 않는 경우
//                    let inputString = text.trimmingCharacters(in: .whitespacesAndNewlines)
//                    guard let oldString = textView.text, let newRange = Range(range, in: oldString) else { return true }
//                    let newString = oldString.replacingCharacters(in: newRange, with: inputString).trimmingCharacters(in: .whitespacesAndNewlines)
//
//                    let characterCount = newString.count
//                    guard characterCount <= 300 else { return false }
//                    updateRemainCountLabel(count: characterCount)
//
//                    return true
        
        // 공백 개행을 카운트하는 경우
        guard let str = textView.text else { return true }
        let newLength = str.count + text.count - range.length
        
        updateRemainCountLabel(count: newLength)
        
        // 사연이 입력되면 보내기 버튼이 활성화 됨
        self.sendButton.isEnabled = true
        self.sendButton.setGradient(color1: UIColor(red: 133/255, green: 129/255, blue: 255/255, alpha: 1), color2: UIColor(red: 152/255, green: 107/255, blue: 255/255, alpha: 1))
        
        // 사연의 길이가 300이 넘으면 더이상 입력되지 않ㅇ
        return newLength < 300
    }
}
