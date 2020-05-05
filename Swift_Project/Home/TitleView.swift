//
//  TitleNavigationScrollView.swift
//  Swift_Project
//
//  Created by lvzheng on 2020/4/29.
//  Copyright © 2020 lvzheng. All rights reserved.
//

import UIKit

class TitleView: UIScrollView {
    var titles: [String] = Array()
    let line = UIView()
    
    convenience init(frame: CGRect, titles: [String]) {
        self.init(frame: frame)
        self.titles = titles
        self.showsHorizontalScrollIndicator = false
        
        let contentWidth = CGFloat(titles.count * 100)
        if  contentWidth > frame.width {
            self.contentSize = CGSize(width: contentWidth, height: 0)
        }
        
        for (index, title) in titles.enumerated() {
            let label = UILabel(frame: CGRect(x: index * 100, y: 0, width: 100, height: 40))
            label.text = title
            label.font = UIFont.systemFont(ofSize: 13)
            label.textAlignment = .center
            label.tag = 1000 + index
            label.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(gestureAction(gesture:)))
            label.addGestureRecognizer(tap)
            self.addSubview(label)
        }
        
        line.frame = CGRect(x: 30, y: 42, width: 40, height: 3)
        line.backgroundColor = .orange
        self.addSubview(line)
    }
    
    @objc func gestureAction(gesture: UIGestureRecognizer) {
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
