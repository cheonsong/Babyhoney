//
//  SendVC+keyboard.swift
//  Babyhoney
//
//  Created by yeoboya_211221_03 on 2022/01/11.
//

import Foundation
import UIKit

extension SendViewController {
    
    // 키보드가 나타나고 사라지는 이벤트를 처리하는 함수
    @objc func adjustInputView(noti: Notification) {
        guard let userInfo = noti.userInfo else { return }
        guard let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        let adjustmentHeight = keyboardFrame.height - view.safeAreaInsets.bottom
        if noti.name == UIResponder.keyboardWillShowNotification {
            // 키보드가 올라오면 제약조건을 걸어줘 뷰의 위치를 재조정함
            bottomConstraint.constant = adjustmentHeight
            editFlag = true
        }
        else {
            // 키보드가 내려가면 제약조건을 0으로 걸어줌
            bottomConstraint.constant = 0
            editFlag = false
        }
        print("\(keyboardFrame.height)")
    }
    
    
    // 바깥 뷰 터치시 이벤트 처리
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if let touch = touches.first , touch.view == self.backgroundView! {
            
            // 텍스트뷰를 편집중이지 않은경우 이전 화면으로
            if(!editFlag) {
                self.presentingViewController?.dismiss(animated: true, completion: nil)
            } else {
                // 텍스트뷰 편집 시 편집 종료, 키보드 내림
                self.view.endEditing(true)
            }
        }
    }
}
