//
//  ProtocolObject.swift
//  Swift_Project
//
//  Created by 吕征 on 2020/10/9.
//  Copyright © 2020 lvzheng. All rights reserved.
//

import UIKit

class ProtocolObject: NSObject, SomeProtocol {
    var name: String {
        set {
        }
        
        get {
            return "protocol object name"
        }
    }
    
    func printSelfName() {
        print("My name is \(NSStringFromClass(type(of: self)))")
    }
    
    subscript(index: Int) -> Int {
        get {
            return index
        }
    }
    
    
}

protocol SomeProtocol {
    var name: String { get }
    func changeColor(color: UIColor)
    // 下标
    subscript (index: Int) -> Int {get}
    func printSelfName()
}

extension SomeProtocol {
    var name: String {
        get {
            return "define name"
        }
    }
    
    // 在extension中提供默认实现，可以使方法变成可选实现
    func printSelfName() {
        print("defint print Name")
    }
    
    func changeColor(color: UIColor) {
        print("defint changeColor Action")
    }
    
    subscript (index: Int) -> Int{
        return index
    }    
}

// 协议的继承
protocol SubProtocol: SomeProtocol {
    
}

// 继承与AnyObject的协议只能被类使用
protocol ClassProtocol: AnyObject {
    
}

extension Int: SubProtocol {
    
    subscript(index: Int) -> Int {
        return 1
    }
    
    func changeColor(color: UIColor) {
        
    }
}
