//
//  NetWorkBaseModel.swift
//  Swift_Project
//
//  Created by lvzheng on 2020/4/10.
//  Copyright © 2020 lvzheng. All rights reserved.
//

import UIKit
import ObjectMapper

struct NetWorkBaseModel<T: Mappable>: Mappable {
    
    var code: Int? //编码
    var text: String?
    var data: Dictionary<String, Any>?//返回数据
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        code <- map["code"]
        text <- map["text"]
        data <- map["data"]
    }
}

struct YNormalModel: Mappable {
    init?(map: Map) {
    }
    init() {
    }
    mutating func mapping(map: Map) {
        
    }
}
