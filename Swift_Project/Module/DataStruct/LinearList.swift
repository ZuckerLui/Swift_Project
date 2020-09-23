//
//  linearlistModule.swift
//  Swift_Project
//
//  Created by 吕征 on 2020/9/18.
//  Copyright © 2020 lvzheng. All rights reserved.
//

import UIKit

// 自定义拷贝协议
protocol Copyable {
    func copy() -> Self
}

// 节点
class LinearListNode: Copyable{
    var data: String
    var next: LinearListNode?
    
    // 为对象定义深拷贝方法，注意不能用Node.init()，因为继承于Node的子类也会继承copy方法，这时候子类copy出来的会是Node类型，而不是子类该有的类型
    func copy() -> Self {
        let obj = type(of: self).init(self.data, self.next)
        return obj
    }
    
    required init(_ data: String, _ next: LinearListNode?) {
        self.data = data
        self.next = next
    }
}

class LinearList {
    var head: LinearListNode?
    var tail: LinearListNode?
    
    init(_ head: LinearListNode?, _ tail: LinearListNode?) {
        self.head = head
        self.tail = tail
    }
    
    var length: Int {
        get {
            var num = 0
            var temp: LinearListNode? = head
            while let node = temp { // 这种写法叫做可选绑定，将可选类型的值进行判断，并赋值给一个常量或者变量
                num += 1
                temp = node.next
            }
            return num
        }
    }
    
    // 根据下标查找
    func foundNode(at index: Int) -> LinearListNode? {
        if length == 0 {
            return nil
        } else if index == 0 {
            return head
        } else if index == length - 1 {
            return tail
        } else if index >= 0 && index < length{
            var temp = 0
            var tempNode = head
            var resultNode: LinearListNode?
            while let node = tempNode {
                if temp == index {
                    resultNode = node
                    break
                }
                temp += 1
                tempNode = tempNode?.next
            }
            return resultNode
        }
        return nil
    }
    
    // 根据值查找
    func foundNode(_ value: String) -> [LinearListNode] {
        var result: [LinearListNode] = []
        var tempNode = head
        while let node = tempNode {
            if node.data == value {
                result.append(node)
            }
            tempNode = tempNode._rlmInferWrappedType()
        }
        return result
    }
    
    // 从头部插入
    func appendToHead(_ value: String) {
        let newNode = LinearListNode.init(value, nil)
        if let first = head {
            newNode.next = first
            head = newNode
        } else {
            head = newNode
            tail = head
        }
    }
    
    // 尾部插入
    func appendToTail(_ value: String) {
        let newNode = LinearListNode.init(value, nil)
        if let last = tail {
            last.next = newNode
            tail = newNode
        } else {
            tail = newNode
            head = newNode
        }
    }
    
    // 在某一节点插入
    func append(_ value: String, index: Int) {
        if length == 0 || index == 0{ // 链表为空 || 插入到头部
            appendToHead(value)
        } else if index == length - 1 {  // 插入到尾部
            appendToTail(value)
        } else if index > 0 && index < length {
            let newNode = LinearListNode.init(value, nil)
            let preNode = foundNode(at:index - 1)
            let oldNode = preNode?.next
            preNode?.next = newNode
            newNode.next = oldNode
        }
    }
    
    // 就地反转，直接将链表本身反转，不产生新的链表
    func reverse(_ head: LinearListNode?) -> LinearListNode? {
        if head == nil || head?.next == nil {
            return head
        }
        // 递归，递归到最后一层，返回tail，然后每一次的执行都是将下一个节点的next指向上一个节点，最后执行第一层，结束
        let newHead = reverse(head?.next)
        
        head?.next?.next = head
        
        head?.next = nil
        self.head = newHead
        return newHead
    }
    
    //遍历反转，将节点一个一个拿出，塞到新的链表中，并改变节点的next指向，生成一个新的链表(由于node是引用类型，所以改变node的next指针，原链表也会改变，所以node必须copy之后才能使用)
    func reverse1(_ head: LinearListNode?) -> LinearList? {
        let newList = LinearList(nil, nil)
        var newHead = head?.copy()
        var b = head?.next?.copy()
        newHead?.next = nil
        newList.tail = newHead
        while let first = b {
            let tempNode = first.next?.copy()
            first.next = newHead
            newHead = b
            b = tempNode
        }
        newList.head = newHead
        return newList
    }
    
    // 打印
    func printSelf() {
        var tempNode = head
        while let node = tempNode {
            print(node.data)
            tempNode = tempNode?.next
        }
    }
}
