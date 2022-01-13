//
//  ListVC+TableView.swift
//  Babyhoney
//
//  Created by yeoboya_211221_03 on 2022/01/11.
//

import Foundation
import UIKit
import Alamofire

extension ListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.rowHeight
    }
}

extension ListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return self.list.count
        }
        // Section이 1이고 페이징 중이며 다음 페이지가 남아있을 경우에는 스피너가 있는 셀을 출력하기 위해 1을 리턴
        else if section == 1 && isPaging && hasNextPage {
            return 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let story = self.list[indexPath.row]
            
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath) as! ListCell
            
            // 프로필 사진은 값이 없을경우 디폴트
            if(story.photo! != "") {
                let data = try? Data(contentsOf: URL(string: story.photo!)!)
                cell.userImage.image = UIImage(data: data!)
            }
            cell.nickname?.text = story.nickName!
            cell.sexImage?.image = story.gender! == "M" ? UIImage(named: "badge_sex_m.png") : UIImage(named: "badge_sex_fm.png")
            cell.storyView?.backgroundColor = story.gender! == "M" ? colorManager.color238 : colorManager.fmColor
            cell.storyRootView?.backgroundColor = story.gender! == "M" ? colorManager.color238 : colorManager.fmColor
            cell.storyView?.text = story.story!
            
            // 현재 시간과 사연이 입력된 시간을 비교
            let tis = compareDate(prevTime: story.time!)
            
            if (tis >= 60*60*24) {
                // 하루이상
                cell.time?.text = "오래전"
            } else if (tis > 60*60) {
                // 1~23시간
                cell.time?.text = "\(tis/3600)시간 전"
            } else if (tis > 60) {
                // 1~59분
                cell.time?.text = "\(tis/60)분 전"
            } else {
                // 1~59초
                cell.time?.text = "\(tis)초 전"
            }
            
            return cell
        } else {
            // Section1 Loading중이므로 스피너를 작동시켜줌
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "LoadingCell", for: indexPath) as! LoadingCell
            
            cell.start()
            
            return cell
        }
    }
}
