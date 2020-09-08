//
//  String+Extension.swift
//  Swift_Project
//
//  Created by lvzheng on 2020/9/6.
//  Copyright © 2020 lvzheng. All rights reserved.
//

import Foundation

extension String {
    /// 替换字符串
    public mutating func replace(_ string: String, with: String) -> String {
        return replacingOccurrences(of: string, with: with)
    }
    
    /// 计算宽高
    public func getSize(_ size: CGSize, attributes: [NSAttributedString.Key: Any]) -> CGSize {
        let rect = NSString(string: self).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
        return CGSize(width: ceil(rect.width), height: ceil(rect.height))
    }

    /// 转为Int类型
    public func toInt() -> Int? {
        if let num = NumberFormatter().number(from: self) {
            return num.intValue
        } else {
            return nil
        }
    }
    
    /// 转为Double类型
    public func toDouble() -> Double? {
        if let num = NumberFormatter().number(from: self) {
            return num.doubleValue
        } else {
            return nil
        }
    }
    
    /// 转为Float类型
    public func toFloat() -> Float? {
        if let num = NumberFormatter().number(from: self) {
            return num.floatValue
        } else {
            return nil
        }
    }
    
    /// 转为CGFloat类型
    public func toCGFloat() -> CGFloat? {
        if let num = NumberFormatter().number(from: self) {
            return CGFloat(num.doubleValue)
        } else {
            return nil
        }
    }

    /// 添加下标索引
    public subscript(start: Int, length: Int) -> String {
        get {
            let index1 = index(startIndex, offsetBy: start)
            let index2 = index(index1, offsetBy: length)
            return String(self[index1..<index2])
        }
        set {
            let tmp = self
            var s = ""
            var e = ""
            for (idx, item) in tmp.enumerated() {
                if (idx < start) {
                    s += "\(item)"
                }
                if (idx >= start + length) {
                    e += "\(item)"
                }
            }
            self = s + newValue + e
        }
    }
    
    /// 添加下标索引
    public subscript(index: Int) -> String {
        get {
            return String(self[self.index(startIndex, offsetBy: index)])
        }
        set {
            let tmp = self
            self = ""
            for (idx, item) in tmp.enumerated() {
                if idx == index {
                    self += "\(newValue)"
                } else {
                    self += "\(item)"
                }
            }
        }
    }
}
