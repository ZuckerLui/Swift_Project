//
//  pageTableView.swift
//  Swift_Project
//
//  Created by lvzheng on 2020/4/29.
//  Copyright © 2020 lvzheng. All rights reserved.
//

import UIKit

let pageViewCellIdentifier = "pageViewCellIdentifier"

typealias scrollBlock = (_ newY: CGFloat) -> Void

class PageView: UIScrollView, UITableViewDelegate, UITableViewDataSource {
    var currentTableView: UITableView?
    // 子tableView能否滑动
    var subCanScroll: Bool = false
    var scrollBlock: scrollBlock?
    var fingerIsTouch = false
    var clickCellBlock: ((_ indexPath: IndexPath) -> Void)?
    
    
    convenience init(frame: CGRect, count: Int) {
        self.init(frame: frame)
        self.contentSize = CGSize(width: self.width * CGFloat(count), height: 0)
        self.isPagingEnabled = true
        for index in 0...count {
            let tableView = self.creatTableView(frame: CGRect(x: self.width * CGFloat(index), y: 0, width: self.width, height: self.height))
            if index == 0 {
                self.currentTableView = tableView
            }
            self.addSubview(tableView)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func creatTableView(frame: CGRect) -> UITableView {
        let tableView = UITableView(frame: frame, style: .plain)
        tableView.rowHeight = 60
        tableView.bounces = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: pageViewCellIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }
    
    func scrollTo(_ index: Int) {
        self.setContentOffset(CGPoint(x: self.width * CGFloat(index), y: 0), animated: true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PageView {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: pageViewCellIdentifier)!
        if indexPath.row == 49 {
            cell.textLabel?.text = "the last one"
        } else {
            cell.textLabel?.text = "好长好长的内容"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let block = clickCellBlock {
            block(indexPath)
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.fingerIsTouch = true
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        self.fingerIsTouch = false
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if !self.subCanScroll {
            scrollView.contentOffset = CGPoint.zero
            return
        }
        self.scrollBlock?(scrollView.contentOffset.y)
    }
}

