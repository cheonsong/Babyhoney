//
//  LoadingCell.swift
//  Babyhoney
//
//  Created by cheonsong on 2022/01/14.
//

import UIKit

class LoadingCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView! // 페이징 로딩시에 출력할 스피너
    
    func start() {
        // 스피너 에니메이션 시작
        activityIndicatorView.startAnimating()
    }
}
