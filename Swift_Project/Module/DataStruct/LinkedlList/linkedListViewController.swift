//
//  linkedListViewController.swift
//  Swift_Project
//
//  Created by 吕征 on 2020/9/27.
//  Copyright © 2020 lvzheng. All rights reserved.
//

import UIKit

class linkedListViewController: UIViewController {
    var linearList: LinearList?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.creatLinkedList()
    }

    // 创建单链表
    func creatLinkedList() {
        let listData = ["1", "2", "3", "4", "5", "6", "7", "8"]
        var preNode: LinearListNode?
        var headNode: LinearListNode?
        for (index, value) in listData.enumerated() {
            let node = LinearListNode(value, nil)
            if index == 0 {
                headNode = node
            }
            preNode?.next = node
            preNode = node
        }
        linearList = LinearList(headNode,nil)
    }

    // 单链表反转
    @objc func linearListReverseAction(_ sender: UIButton) {
        linearList?.reverse(linearList?.head)
        linearList?.printSelf()
    }
}

extension linkedListViewController {
    func setupUI() {
        self.view.backgroundColor = .white
        self.view.addSubview(self.creatbtn(CGRect(x: 50, y: 100, width: 100, height: 40), "链表", #selector(linearListReverseAction(_:))))
//        self.view.addSubview(self.creatbtn(CGRect(x: 200, y: 100, width: 100, height: 40), "二叉树", #selector(creatBinaryTree(_:))))
    }
    
    func creatbtn(_ frame: CGRect, _ title: String, _ action: Selector) -> UIButton {
        let btn = UIButton.init(type: .custom)
        btn.frame = frame
        btn.setTitle(title, for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.addTarget(self, action: action, for: .touchUpInside)
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.black.cgColor
        return btn
    }
}
