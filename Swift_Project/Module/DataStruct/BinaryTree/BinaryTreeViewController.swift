//
//  BinaryTreeViewController.swift
//  Swift_Project
//
//  Created by 吕征 on 2020/9/27.
//  Copyright © 2020 lvzheng. All rights reserved.
//

import UIKit

class BinaryTreeViewController: UIViewController {
    var binaryTree: BinaryTree<String>?
    let BinaryTreeData: [String?] = ["A", "B", "D", "H",nil, nil, "I", nil, nil, "E", "J", nil, nil, nil,"C","F", nil, nil, "G"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        // 先序创建二叉树
        self.binaryTree = BinaryTree.init(BinaryTreeData)
    }
    
    // 先序遍历二叉树
    @objc func previousOrderAction(_ sender: UIButton) {
        self.binaryTree?.preOrderTraverse(t: self.binaryTree?.root)
    }
    
    // 层级遍历二叉树
    @objc func levelOrderAction(_ sender: UIButton) {
        self.binaryTree?.levelOrder(self.binaryTree?.root)
    }
    
}

extension BinaryTreeViewController {
    func setupUI() {
        self.view.backgroundColor = .white
        self.view.addSubview(self.creatbtn(CGRect(x: 50, y: 100, width: 100, height: 40), "先序创建二叉树", #selector(previousOrderAction(_:))))
        self.view.addSubview(self.creatbtn(CGRect(x: 200, y: 100, width: 100, height: 40), "层级遍历二叉树", #selector(levelOrderAction(_:))))
    }
    
    func creatbtn(_ frame: CGRect, _ title: String, _ action: Selector) -> UIButton {
        let btn = UIButton.init(type: .custom)
        btn.frame = frame
        btn.setTitle(title, for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.adjustsFontSizeToFitWidth = true
        btn.addTarget(self, action: action, for: .touchUpInside)
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.black.cgColor
        return btn
    }
}
