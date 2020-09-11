//
//  ClosuresViewController.swift
//  Swift_Project
//
//  Created by lvzheng on 2020/9/6.
//  Copyright © 2020 lvzheng. All rights reserved.
//

import UIKit

typealias textBlock = (_ agrument: String) -> String

class ClosuresViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "闭包"
        self.view.addSubview(self.sortLabel)
        self.view.addSubview(self.escapingLabel)
        self.view.addSubview(self.noescapingLabel)
    }
    
    // 非逃逸闭包label
    lazy var noescapingLabel: UILabel = {
        let label = UILabel.init(frame: CGRect(x: 0, y: 240, width: 300, height: 40))
        label.backgroundColor = .yellow
        label.text = "noescaping label"
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(noescaptingAction(tap:)))
        label.addGestureRecognizer(tap)
        label.isUserInteractionEnabled = true
        return label
    }()
    
    // 逃逸闭包label
    lazy var escapingLabel: UILabel = {
        let label = UILabel.init(frame: CGRect(x: 0, y: 170, width: 300, height: 40))
        label.backgroundColor = .orange
        label.text = "escaping label"
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(escapingAction(tap:)))
        label.addGestureRecognizer(tap)
        label.isUserInteractionEnabled = true
        return label
    }()
    
    // 字符串排序
    lazy var sortLabel: UILabel = {
        let label = UILabel.init(frame: CGRect(x: 0, y: 100, width: 300, height: 40))
        label.backgroundColor = .red
        label.text = "OPSABDCL"
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(charSortAction(tap:)))
        label.addGestureRecognizer(tap)
        label.isUserInteractionEnabled = true
        return label
    }()
}

extension ClosuresViewController {
    @objc func noescaptingAction(tap: UITapGestureRecognizer) {
        
    }
    
    func noescapingFunc(_ text: String, successBlock: (_ newText: String) -> Void) {
        
    }
}

extension ClosuresViewController {
    @objc func escapingAction(tap: UITapGestureRecognizer) {
        let label = tap.view as! UILabel
        self.escapingFunc(label.text!) {[weak label] (newText) in
            label?.text = newText
        }
    }
    
    func escapingFunc(_ text: String, successBlock: @escaping (_ newText: String) -> Void) {
        let newText = "completion " + text
        successBlock(newText)
    }
}

extension ClosuresViewController {
    @objc func charSortAction(tap: UITapGestureRecognizer) {
        let label = tap.view as! UILabel
        
        // 遍历字符串里面的字符
        var chars = [String]()
        for index in 0..<label.text!.count {
            chars.append(label.text![index])
        }
        // 闭包表达式表达方式
        let result = chars.sorted(by: backChar(c1:c2:))
        // 简写
        //let result = label.text!.sorted(by: <)
        print("string sorted result = \(result)")
        var newText = ""
        for item in result {
            newText += item
        }
        label.text = newText
    }
    
    func backChar(c1: String, c2: String) -> Bool {
        return c1 < c2
    }
}
