//
//  HomeTableview.swift
//  Swift_Project
//
//  Created by lvzheng on 2020/5/5.
//  Copyright © 2020 lvzheng. All rights reserved.
//

import UIKit

class HomeTableview: UITableView, UIGestureRecognizerDelegate {

    // 两个手势都能响应，拖动时，两个tableview会同时滑动
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool{
        return true
    }
}

class HomeTableViewCell: UITableViewCell {
    var pageView: PageView?
    var openDetailVc: (() -> Void)?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        pageView = PageView(frame: CGRect(x: 0, y: 0, width: ScreenSize.width, height: ScreenSize.height + 1000), count: 5)
        self.contentView.addSubview(pageView!)
        pageView?.clickCellBlock = {[weak self] (indexPath) in
            if let block = self?.openDetailVc {
                block()
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
