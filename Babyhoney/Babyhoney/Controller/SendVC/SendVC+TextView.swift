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
        // 편집이 시작되면 플레이스홀더를 지우고 텍스트컬러를 수정한다
        // 텍스트뷰에서는 플레이스홀더가 존재하지 않기에 임의로 텍스트를 넣어서 플레이스홀더 처럼 보이게 해야한다.
        // 그런데 사용자가 이 플레이스홀더를 모르고 몇자 지웠다고해서 사연을 입력한 것이 아니기때문에
        // 그런 상황을 방지하기 위해 입력된 사연과 플레이스홀더를 비교함
        if placeholder.contains(textView.text) {
            self.textView.text = ""
            self.textView.textColor = colorManager.color17
            self.updateRemainCountLabel(count: 0)
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        // 편집이 끝났는데 공백이라면 플레이스홀더 출력
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = placeholder
            textView.textColor = colorManager.color102
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        guard let str = textView.text else { return true }

        let newLength = str.count + text.count - range.length
        
        // 사연이 300자 이상이면 알림창 출력
        guard newLength < 301 else {
            let alert = UIAlertController(title: "알림", message: "300자 이상 입력할 수 없습니다.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
            
            self.present(alert,animated: false)
            
            return false
        }
        
        
        updateRemainCountLabel(count: newLength)
        
//        if newLength == 0 {
//            textView.text = placeholder
//            textView.textColor = colorManager.color102
//            updateRemainCountLabel(count: 0)
//        }
        
        // 사연이 입력되면 보내기 버튼이 활성화 됨 (10자 이상부터)
        if (newLength >= 10 && newLength < 300) {
            // 사연에 공백뿐인 경우 버튼이 활성화되지 않음
            if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                return true
            }
            
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
            updateRemainCountLabel(count: newLength)
        }
        
        // 사연의 길이가 300이 넘으면 더이상 입력되지 않음
        return newLength < 301
    }
    
}
