//
//  DataStructViewController.swift
//  Swift_Project
//
//  Created by 吕征 on 2020/9/18.
//  Copyright © 2020 lvzheng. All rights reserved.
//

import UIKit

class DataStructViewController: UIViewController {
    var listData = ["1", "2", "3", "4", "5", "6", "7", "8"]
    var linearList: LinearList?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var preNode: LinearListNode?
        var headNode: LinearListNode?
        for (index, value) in listData.enumerated() {
            let node = LinearListNode(value, nil)
            if index == 0 {
                headNode = node
            }
            preNode?.next = node
            preNode = node
        }
        linearList = LinearList(headNode,nil)

    }

    // 链表反转
    @IBAction func linearListReverseAction(_ sender: Any) {
        linearList?.reverse(linearList?.head)
        linearList?.printSelf()
    }
}
