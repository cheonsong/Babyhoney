//
//  StoryCellTableViewCell.swift
//  Babyhoney
//
//  Created by cheonsong on 2022/01/14.
//

import UIKit

class StoryCell: UITableViewCell {
    

    @IBOutlet weak var nickname: UILabel!
    @IBOutlet weak var sexImage: UIImageView!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var storyRootView: UIView!
    @IBOutlet weak var storyLabel: UILabel!
    
    @IBAction func tapMoreButton(_ sender: Any) {
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        storyRootView.layer.cornerRadius = 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
