//
//  BinaryTree.swift
//  Swift_Project
//
//  Created by 吕征 on 2020/9/20.
//  Copyright © 2020 lvzheng. All rights reserved.
//

import UIKit

class BinaryTreeNode<T>: NSObject {
    var data: T?
    var lChild: BinaryTreeNode<T>?
    var rChild: BinaryTreeNode<T>?
    var lTag: Bool = false    //lTag = true，lChild指向前驱；否则，指向左子树
    var rTag: Bool = false    //rTag = true，rChild指向后续；否则，指向右子树

    init(_ data: T?) {
        self.data = data
    }
}

class BinaryTree<T> {
    var root: BinaryTreeNode<T>?
    fileprivate var nodes: Array<T?>
    fileprivate var index = -1
    
    init(_ items: Array<T?>) {
        self.nodes = items
        self.root = self.creatTree()
    }
    
    var maxDepth: Int {
        return maxDepth(root)
    }
    
    // 计算二叉树的最大深度
    private func maxDepth (_ root: BinaryTreeNode<T>?) -> Int {
        guard let root = root else {
            return 0
        }
        let leftDepth = maxDepth(root.lChild)
        let rightDepth = maxDepth(root.rChild)
        print(leftDepth, rightDepth)
        return max(leftDepth, rightDepth) + 1
    }
    
    // ["A", "B", "D", "H",nil, nil, "I", nil, nil, "E", "J", nil, nil, nil,"C","F", nil, nil, "G"]
    // 以先序二叉树创建二叉树
    fileprivate func creatTree() -> BinaryTreeNode<T>? {
        self.index += 1
        if self.index < self.nodes.count && index >= 0{
            let item = self.nodes[index]
            if item == nil {
                return nil
            } else {
                let root = BinaryTreeNode.init(item)
                root.lChild = creatTree()
                root.rChild = creatTree()
                return root
            }
        }
        return nil
    }
    
    //前序遍历: 先遍历根节点,再遍历左子树,最后遍历右子树. 从A开始，到B，B是父节点,到D，D也是父节点，再到H,H没有子树,就完成了DHI这颗小树的左节点遍历，然后遍历右子树I，后面以此类推
    func preOrderTraverse(t: BinaryTreeNode<T>?) {
        guard let tNode = t else {
            return
        }
        
        print(tNode.data, tNode.lChild?.data)
        preOrderTraverse(t: tNode.lChild)
        preOrderTraverse(t: tNode.rChild)
    }
    // 前序遍历结果：ABDHIEJCFG => A->(B->(D->H->I)->(E->J))->(C->F->G)

    //中序遍历
    func inOrderTraverse(t: BinaryTreeNode<T>?) {
        guard let tNode = t else {
            return
        }
        inOrderTraverse(t: tNode.lChild)
        print(tNode.data)
        inOrderTraverse(t: tNode.rChild)
    }
    //中序遍历结果：HDIBJEAFCG => ((H<-D->I)<-B->(J<-E))<-A->(F<-C->G)

    //后序遍历
    func postOrderTraverse(t: BinaryTreeNode<T>?) {
        guard let tNode = t else {
            return
        }
        postOrderTraverse(t: tNode.lChild)
        postOrderTraverse(t: tNode.rChild)
        print(tNode.data)
    }
   // 后序遍历结果：HIDJEBFGCA => ((H->I->D)->(J->E)->B)->(F->G->C)->A
//          A
//       /     \
//      B       C
//    /   \     / \
//   D     E   F   G
//  / \   /
// H   I J
    
    //层级遍历--队列实现 : 层次遍历就是一排一排，从左往右遍历
    public func levelOrder(_ root : BinaryTreeNode<String>?){
        var res = [[String]]()
        
        //用数组实现队列
        var queue = [BinaryTreeNode<String>]()
        
        if let root = root {
            queue.append(root)
        }
        
        while queue.count > 0 {
            let size = queue.count
            var level = [String]()
            
            for _ in 0..<size{
                let node = queue.removeFirst()
                
                level.append(node.data ?? "null")
                
                if let left = node.lChild {
                    queue.append(left)
                }
                if let right = node.rChild{
                    queue.append(right)
                }
            }
            res.append(level)
        }
        print("res \(res)")
    }
}


