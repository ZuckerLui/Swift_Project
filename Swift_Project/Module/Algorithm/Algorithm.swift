//
//  algorithm.swift
//  Swift_Project
//
//  Created by 吕征 on 2020/9/26.
//  Copyright © 2020 lvzheng. All rights reserved.
//

import UIKit

public enum AlgorithmResult {
    case OK
    case Error(message:String)
}

class Algorithm: NSObject {
    
    // 二分查找
    func binarySearch(array: [Int], target: Int) -> (Int?, AlgorithmResult) {
        guard array.count != 0 else {
            return (nil, AlgorithmResult.Error(message: "search array is empty!"))
        }
        
        var left = 0
        var right = array.count - 1
        
        // 用区间中间的数做对比，没有找到就继续折半
        while left <= right {
            let mid = (left + right)/2
            if array[mid] == target {
                return (mid, AlgorithmResult.OK)
            } else if array[mid] < target {
                left = mid + 1
            } else if array[mid] > target {
                right = mid - 1
            }
        }
        return (nil, AlgorithmResult.Error(message: "no have target in array!"))
    }
}
