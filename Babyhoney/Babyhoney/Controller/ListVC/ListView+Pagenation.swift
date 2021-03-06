//
//  ListView+Pagenation.swift
//  Babyhoney
//
//  Created by yeoboya_211221_03 on 2022/01/13.
//

import Foundation
import UIKit
import UIKit

extension ListViewController : UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offsetY = scrollView.contentOffset.y
        let tableViewContentSize = tableView.contentSize.height
        let height = scrollView.frame.height
        
        // 테이블뷰의 스크롤뷰가 끝까지 스크롤 됐을 경우
        if offsetY > (tableViewContentSize - height) {
        
            // 페이징중이지 않으며 다음 페이지가 있을 경우 페이징 시ㄱ
            if isPaging == false && hasNextPage {
                beginPaging()
            }
        }
        
    }
    
    func beginPaging() {
        
        // 페이징중이라는 것을 알려줌
        isPaging = true
        
        // 스피너가 있는 섹션을 리로드
        DispatchQueue.main.async {
            self.tableView.reloadSections(IndexSet(integer: 1), with: .none)
        }
        
        // 그 후에 페이징 시작
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.paging()
        }
    }
}
