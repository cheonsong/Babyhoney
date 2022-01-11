//
//  ListVC+TableView.swift
//  Babyhoney
//
//  Created by yeoboya_211221_03 on 2022/01/11.
//

import Foundation
import UIKit

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.rowHeight
    }
}

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let story = self.list[indexPath.row]
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath) as! ListCell
        
        if(story.photo! != "") {
            let data = try? Data(contentsOf: URL(string: story.photo! ?? "")!)
            cell.userImage.image = UIImage(data: data!)
        }
        
        cell.nickname?.text = story.nickName!
        cell.sexImage?.image = story.gender! == "M" ? UIImage(named: "badge_sex_m.png") : UIImage(named: "badge_sex_fm.png")
        cell.storyView?.text = story.story!
        
        return cell
    }
}
