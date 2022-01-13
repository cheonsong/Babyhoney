//
//  ListCell.swift
//  Babyhoney
//
//  Created by yeoboya_211221_03 on 2022/01/11.
//

import Foundation
import UIKit

class ListCell: UITableViewCell {
    
    @IBOutlet weak var userImage: UIImageView!  // 프로필사진
    @IBOutlet weak var sexImage: UIImageView!   // 성별이미지
    @IBOutlet weak var nickname: UILabel!       // 별명
    @IBOutlet weak var time: UILabel!           // 포스트된 시간
    @IBOutlet weak var optionButton: UIButton!  // 더보기버튼
    @IBOutlet weak var storyView: UILabel!      // 사연창
    @IBOutlet weak var storyRootView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

class LoadingCell: UITableViewCell {
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView! // 페이징 로딩시에 출력할 스피너
    
    func start() {
        // 스피너 에니메이션 시작
        activityIndicatorView.startAnimating()
    }
}
 
