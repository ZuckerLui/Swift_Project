//
//  ProtocolView.swift
//  Swift_Project
//
//  Created by lvzheng on 2020/4/27.
//  Copyright © 2020 lvzheng. All rights reserved.
//

import UIKit

typealias changeColorAndText = (_ text: String, _ color: UIColor) -> Void

class ProtocolView: UIView {
    let label = UILabel()
    weak var delegate: changeViewProtocol?
    var changeBlock: changeColorAndText?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        label.frame = CGRect(x: 0, y: 0, width: frame.width, height: 30)
        self.addSubview(label)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        delegate?.displayContent?(view: self)
        changeBlock?("sun", UIColor.green)
    }
    
    public func changeColorAndText(block: changeColorAndText) -> Void {
        block("sun", UIColor.green)
    }
}

@objc protocol changeViewProtocol {
    @objc optional func displayContent(view: ProtocolView)
}
