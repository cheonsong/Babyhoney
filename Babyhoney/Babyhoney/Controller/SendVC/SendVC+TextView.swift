//
//  SendVC+TextView.swift
//  Babyhoney
//
//  Created by yeoboya_211221_03 on 2022/01/11.
//

import Foundation
import UIKit

// MARK: - TextViewDelegate
extension SendViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        // 편집이 시작되면 플레이스홀더를 지우고 텍스트컬러를 수정함
        if placeholder.contains(textView.text) {
            self.textView.text = ""
            self.textView.textColor = UIColor(red: 17/255, green: 17/255, blue: 17/255, alpha: 1)
            self.updateRemainCountLabel(count: 0)
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = placeholder
            textView.textColor = UIColor(red: 102/255, green: 102/255, blue: 102/255, alpha: 1)
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        // 공백 개행을 카운트하는 경우
        guard let str = textView.text else { return true }
        let newLength = str.count + text.count - range.length
        
        // 사연이 300자 이상이면 알림창 출력
        guard newLength < 300 else {
            let alert = UIAlertController(title: "알림", message: "300자 이상 입력할 수 없습니다.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
            
            self.present(alert,animated: false)
            
            return false
        }
        
        updateRemainCountLabel(count: newLength)
        
        if newLength == 0 {
            textView.text = placeholder
            textView.textColor = UIColor(red: 102/255, green: 102/255, blue: 102/255, alpha: 1)
            updateRemainCountLabel(count: 0)
        }
        
        // 사연이 입력되면 보내기 버튼이 활성화 됨 (10자 이상부터)
        if (newLength >= 10 && newLength < 300) {
            // 플레이스홀더가 입력돼 있으면 뷰 뷰는 활성화 되지 않음
            if !placeholder.contains(textView.text) {
                self.sendButton.isEnabled = true
                self.sendButton.layer.sublayers?.first?.isHidden = false
            } else {
                updateRemainCountLabel(count: 0)
            }
        // 사연의 길이가 10보다 작으면 보내기 버튼 비활성화
        } else if newLength < 10 {
            self.sendButton.isEnabled = false
            self.sendButton.layer.sublayers?.first?.isHidden = true
        }
        
        // 사연의 길이가 300이 넘으면 더이상 입력되지 않음
        return newLength < 300
    }
    
}
