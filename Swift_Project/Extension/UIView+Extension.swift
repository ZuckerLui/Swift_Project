//
//  UIView+Extension.swift
//  Swift_Project
//
//  Created by lvzheng on 2020/4/29.
//  Copyright © 2020 lvzheng. All rights reserved.
//

import Foundation

extension UIView {
    // 计算属性
    var x: CGFloat {
        set {
            var tempFrame = frame
            tempFrame.origin.x = newValue
            frame = tempFrame
        }
        
        get {
            return frame.origin.x
        }
    }
    
    var y: CGFloat {
        set {
            var tempFrame = frame
            tempFrame.origin.y = newValue
            frame = tempFrame
        }
        
        get {
            return frame.origin.y
        }
    }
    
    var width: CGFloat {
        set{
            var tempFrame = frame
            tempFrame.size.width = newValue
            frame = tempFrame
        }
        
        get {
            return frame.size.width
        }
    }
    
    var height: CGFloat {
        get {
            return frame.size.height
        }
        
        set(newValue) {
            var tempFrame = frame
            tempFrame.size.height = newValue
            frame = tempFrame
        }
    }
    
    var centerX: CGFloat {
        get {
            return self.center.x
        }
        set (newValue){
            var tempFrame = frame
            tempFrame.origin.x = newValue - self.width/2
            frame = tempFrame
        }
    }
    
}
