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
