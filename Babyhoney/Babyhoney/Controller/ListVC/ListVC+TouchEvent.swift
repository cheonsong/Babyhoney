//
//  ListVC+Touch.swift
//  Babyhoney
//
//  Created by yeoboya_211221_03 on 2022/01/12.
//

import Foundation
import UIKit

// MARK: - TouchEvent
// 바깥 뷰 터치시 이벤트 처리
extension ListViewController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if let touch = touches.first , touch.view == self.view {
            self.presentingViewController?.dismiss(animated: true, completion: nil)
        }
    }
}
