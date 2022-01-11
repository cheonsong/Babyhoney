//
//  SendVC+keyboard.swift
//  Babyhoney
//
//  Created by yeoboya_211221_03 on 2022/01/11.
//

import Foundation
import UIKit

extension SendViewController {
    // 키보드 올라갔다는 알림을 받으면 실행되는 메서드
    @objc func keyboardWillShow(_ sender:Notification){
        let userInfo:NSDictionary = sender.userInfo! as NSDictionary
        let keyboardFrame:NSValue = userInfo.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue
        let keyboardRectangle = keyboardFrame.cgRectValue
        let keyboardHeight = keyboardRectangle.height
        keyHeight = keyboardHeight
        if (viewSize == self.view.frame.size.height){
            self.view.frame.size.height -= keyboardHeight
        }
    }
    
    // 키보드 내려갔다는 알림을 받으면 실행되는 메서드
    @objc func keyboardWillHide(_ sender:Notification){
        self.view.frame.size.height += keyHeight!
    }
    
    // 바깥 뷰 터치시 이벤트 처리
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if let touch = touches.first , touch.view == self.view {
            // 텍스트뷰를 편집중이지 않은경우 이전 화면으로
            if(self.view.frame.size.height == viewSize!) {
                self.presentingViewController?.dismiss(animated: true, completion: nil)
            } else {
                // 텍스트뷰 편집 시 편집 종료, 키보드 내림
                self.view.endEditing(true)
            }
        }
    }
}
