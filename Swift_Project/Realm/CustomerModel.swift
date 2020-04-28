//
//  CustomModel.swift
//  Swift_Project
//
//  Created by lvzheng on 2020/4/23.
//  Copyright © 2020 lvzheng. All rights reserved.
//

import UIKit
import RealmSwift
import ObjectMapper

/** 消费类别 */
enum ConsumeType: Int {
    case Food           // 食品
    case Clothing       // 服装
    case cosmetics      // 化妆品
}

/** 消费者 */
class CustomerModel: Object {
    @objc dynamic var name = ""
    @objc dynamic var idCard = ""
    @objc dynamic var address = ""
    
    let items = List<ConsumeItem>()
    override static func primaryKey() -> String? {
        return "idCard"
    }
}

/** 消费项目 */
class ConsumeItem: Object {
    // 项目名
    @objc dynamic var name = ""
    // 金额
    @objc dynamic var cost = 0.0
    // 时间
    @objc dynamic var date = Date()
    // 所属消费类别
    var type: ConsumeType?
    
    let owners = LinkingObjects(fromType: CustomerModel.self, property: "items")
}
