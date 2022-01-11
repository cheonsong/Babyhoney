//
//  ListCell.swift
//  Babyhoney
//
//  Created by yeoboya_211221_03 on 2022/01/11.
//

import Foundation
import UIKit

class ListCell: UITableViewCell {
    
    @IBOutlet weak var userImage: UIImageView!
    
    @IBOutlet weak var sexImage: UIImageView!
    
    @IBOutlet weak var nickname: UILabel!
    
    @IBOutlet weak var time: UILabel!
    
    @IBOutlet weak var optionButton: UIButton!
    
    @IBOutlet weak var storyView: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
}
