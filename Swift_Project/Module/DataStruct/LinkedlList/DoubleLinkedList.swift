//
//  DoubleLinkedList.swift
//  Swift_Project
//
//  Created by 吕征 on 2020/9/24.
//  Copyright © 2020 lvzheng. All rights reserved.
//  双链表

import UIKit

public class DoublelinkedNode<T> {
    var data: T
    var previous: DoublelinkedNode?
    var next: DoublelinkedNode?
    init(_ data: T) {
        self.data = data
    }
}

public enum ErrorStatus {
    case Error(message: String)
    case OK
}

public class DoubleLinkedList<T> {
    public typealias Node = DoublelinkedNode<T>
    
    private var head: Node?
    
    public var isEmpty: Bool {
        return head == nil
    }
    
    public var first: Node? {
        return head
    }
    
    public var last: Node? {
        if isEmpty {
            return nil
        } else if count == 1 {
            return first
        } else {
            var node = first
            while let nextNode = node?.next {
                node = nextNode
            }
            return node
        }
    }
    
    // 链表node个数
    public var count: Int {
        var num = 0
        if isEmpty {
            return num
        }else{
            num = 1
            var tempNode = head?.next
            while let next = tempNode {
                num += 1
                tempNode = next.next
            }
            return num
        }
    }
    
    // 通过位置获取node
    public func node(atIndex index: Int) -> Node? {
        if isEmpty, index < 0, index >= count{
            return nil
        } else if index == 0 {
            return head
        } else {
            var tempIndex = 1
            var node = head?.next
            while tempIndex != index {
                tempIndex += 1
                node = node?.next
            }
            return node
        }
    }
    
    public func insert(data: T, atIndex index: Int) -> ErrorStatus {
        guard index >= 0, index <= count else {
            return ErrorStatus.Error(message: "insert is out of range!")
        }
        let newNode = Node(data)
        if index == 0 {
            if let node = first {
                head = newNode
                newNode.next = node
                node.previous = newNode
            } else {
                head = newNode
            }
        } else {
            let preNode = self.node(atIndex: index - 1)
            let nextNode = self.node(atIndex: index)
            preNode?.next = newNode
            newNode.previous = preNode
            newNode.next = nextNode
            nextNode?.previous = newNode
        }
        return ErrorStatus.OK
    }
    
    public func remove(atIndex index: Int) -> (T?, ErrorStatus) {
        guard !isEmpty else {
            return (nil, ErrorStatus.Error(message: "Link list is Empty!"))
        }
        
        guard index >= 0, index < count else {
            return (nil, ErrorStatus.Error(message: "Index is out of range!"))
        }
        
        let node = self.node(atIndex: index)
        let nextNode = self.node(atIndex: index + 1)
        if index == 0 {
            nextNode?.previous = nil
            head = nextNode
        } else {
            let preNode = self.node(atIndex: index - 1)
            preNode?.next = nextNode
            nextNode?.previous = preNode
        }
        return (node?.data, ErrorStatus.OK)
    }
}

/// 栈：栈也是一种线性表,递归运算是栈的一种应用
public struct Stack<T> {
    private var stackData: [T] = []
    
    public var count: Int {
        return stackData.count
    }
    
    public var isEmpty: Bool {
        return stackData.isEmpty
    }
    
    // 后进先出原则，所以top是数组的最后一个元素
    public var top: T? {
        if  isEmpty {
            return nil
        } else {
            return stackData.last
        }
    }
    
    public mutating func push(data: T) {
        stackData.append(data)
    }
    
    public mutating func pop() -> T? {
        if isEmpty {
            return nil
        } else {
            return stackData.removeLast()
        }
    }
    
    public mutating func removeAll() {
        stackData.removeAll()
    }
    
    public func printAllItem() {
        for item in stackData {
            print(item)
        }
    }
}
