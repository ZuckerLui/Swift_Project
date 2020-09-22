//
//  BinaryTree.swift
//  Swift_Project
//
//  Created by 吕征 on 2020/9/20.
//  Copyright © 2020 lvzheng. All rights reserved.
//

import UIKit

class BinaryTreeNode {
    var value: String
    var left: BinaryTreeNode?
    var right: BinaryTreeNode?

    init(_ value: String) {
        self.value = value
    }
}

class BinaryTree {
    var root: BinaryTreeNode?
    fileprivate var nodes: Array<String>
    fileprivate var index = -1
    
    init(_ items: Array<String>) {
        self.nodes = items
        self.root = self.creatTree()
    }
    
    // 以先序二叉树创建二叉树
    fileprivate func creatTree() -> BinaryTreeNode? {
        self.index += 1
        if self.index < self.nodes.count && index >= 0{
            let item = self.nodes[index]
            if item == "" {
                return nil
            } else {
                let root = BinaryTreeNode.init(item)
                root.left = creatTree()
                root.right = creatTree()
                return root
            }
        }
        return nil
    }
}


