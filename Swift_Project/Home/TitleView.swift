//
//  TitleNavigationScrollView.swift
//  Swift_Project
//
//  Created by lvzheng on 2020/4/29.
//  Copyright © 2020 lvzheng. All rights reserved.
//

import UIKit

//typealias changeBlick = (_ tag: String) -> Void

class TitleView: UIScrollView {
    var titles: [String] = Array()
    let line = UIView()
    var labelArray: [UILabel] = []
    var currentIndex = 1000
    
    var changeBlock: ((_ tag: Int) -> Void)?
    
    convenience init(frame: CGRect, titles: [String]) {
        self.init(frame: frame)
        self.titles = titles
        self.showsHorizontalScrollIndicator = false
        self.backgroundColor = .white
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
            labelArray.append(label)
        }
        
        line.frame = CGRect(x: 30, y: 42, width: 40, height: 3)
        line.backgroundColor = .orange
        self.addSubview(line)
    }
    
    @objc func gestureAction(gesture: UIGestureRecognizer) {
        let view = gesture.view!
        if self.currentIndex == view.tag {
            return
        }
        // 切换标签，滑动对应的页面
        if let block = changeBlock {
            self.currentIndex = view.tag
            let label = labelArray[self.currentIndex - 1000]
            UIView.animate(withDuration: 0.3) { [self] in
                line.centerX = label.centerX
            }
            block(view.tag - 1000)
        }
    }
    
    // 滑动标签
    func scrollLabelTo(_ index: Int) {
        if index == self.currentIndex - 1000 {
            return
        }
        self.currentIndex = 1000 + index
        let label = labelArray[self.currentIndex - 1000]
        UIView.animate(withDuration: 0.3) { [self] in
            line.centerX = label.centerX
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
