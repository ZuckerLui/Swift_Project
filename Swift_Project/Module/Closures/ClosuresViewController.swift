//
//  ClosuresViewController.swift
//  Swift_Project
//
//  Created by lvzheng on 2020/9/6.
//  Copyright © 2020 lvzheng. All rights reserved.
//

import UIKit

typealias textBlock = (_ agrument: String) -> Void

class ClosuresViewController: UIViewController {
    var blockArray: [textBlock] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "闭包"
        self.view.addSubview(self.sortLabel)
        self.view.addSubview(self.closuresLabel)
        
        var msg1 = "拷贝当前变量"
        let closure1 = { [msg1] in print("\(msg1)")}
        msg1 = "修改不影响"
        closure1()
        
        var msg2 = "引用当前变量"
        let closure2 = {print("\(msg2)")}
        msg2 = "修改影响引用值"
        closure2()
        
        self.countUniques([3, 1, 1, 1])
    }
    
    func countUniques<T: Comparable>(_ array: Array<T>) -> Int {
        let sorted = array.sorted(by: <)
    print("sorted = \(sorted)")
      let initial: (T?, Int) = (.none, 0)
      let reduced = sorted.reduce(initial) {
        print("\($0),   \(1)")
        return ($1, $0.0 == $1 ? $0.1 : $0.1 + 1)
      }
        print("reduced = \(reduced)")
        let reduced1 = sorted.reduce(initial) { (result, item) -> (T?, Int) in
            (item, result.0 == item ? result.1 : result.1 + 1)
        }
        print("reduced1 = \(reduced1)")

        return reduced.1
    }
    
    lazy var closuresLabel: UILabel = {
        let label = UILabel.init(frame: CGRect(x: 0, y: 170, width: 300, height: 40))
        label.backgroundColor = .orange
        label.text = "escaping label"
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(closuresAction(tap:)))
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
    
    deinit {
        print("closureViewController deinit")
    }
}

// 逃逸闭包和非逃逸闭包的区别
extension ClosuresViewController {
    var jssx: Int {
        get{
            return 4
        }
    }
    @objc func closuresAction(tap: UITapGestureRecognizer) {
        // @escaping 内部需要弱引用，weak 引用的对象被回收后，指针会被置nil，但是unowned不会
        self.escapingFunc(self.closuresLabel.text!) {[weak self] (newText) in
            // 将一个闭包标记为 @escaping 意味着你必须在闭包中显式地引用 self。
            self?.closuresLabel.text = "block completion"
        }
        
        self.noescapingFunc(self.closuresLabel.text!) {(newText) in
            // @noescaping 可以隐士使用self
            closuresLabel.text = "block completion"
        }
    }
    
    func escapingFunc(_ text: String, successBlock: @escaping (_ newText: String) -> Void) {
        // 逃逸闭包被添加到一个函数外定义的数组中，并没有在函数内展开
        blockArray.append(successBlock)
    }
    
    func noescapingFunc(_ text: String, successBlock: (_ newText: String) -> Void) {
        // 非逃逸闭包无法保存在外部，所以不能添加到外部数组中
//        blockArray.append(successBlock)   -> X
        successBlock(text)
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
