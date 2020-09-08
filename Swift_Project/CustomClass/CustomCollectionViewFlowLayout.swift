//
//  CustomCollectionViewFlowLayout.swift
//  Swift_Project
//
//  Created by lvzheng on 2020/9/7.
//  Copyright © 2020 lvzheng. All rights reserved.
//

import UIKit

class CustomCollectionViewFlowLayout: UICollectionViewFlowLayout {
    var maximumSpacing: CGFloat = 15
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        // 获取系统帮我们计算好的Attributes
        let answer:[UICollectionViewLayoutAttributes] = super.layoutAttributesForElements(in: rect)!
        
        // 遍历结果
        for index in 1...answer.count-1 {
            // 获取cell的Attribute，根据上一个cell获取最大的x，定义为origin
            let currentLayoutAttributes = answer[index]
            let prevLayoutAttributes = answer[index - 1]
            
            //此处根据个人需求，我的需求里面有head cell两类，我只需要调整cell，所以head直接过滤
            if currentLayoutAttributes.representedElementKind == UICollectionView.elementKindSectionHeader {
                continue
            }
            let preX = prevLayoutAttributes.frame.maxX
            let preY = prevLayoutAttributes.frame.maxY
            let curY = currentLayoutAttributes.frame.maxY
            
            // 如果当前cell和precell在同一行
            if preY == curY {
                //满足则给当前cell的frame属性赋值
                //不满足的cell会根据系统布局换行
                var frame = currentLayoutAttributes.frame
                frame.origin.x = preX + self.maximumSpacing
                currentLayoutAttributes.frame = frame
            }
        }
        return answer;
    }
}
