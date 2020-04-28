//
//  userModel.swift
//  Swift_Project
//
//  Created by lvzheng on 2020/4/12.
//  Copyright © 2020 lvzheng. All rights reserved.
//

import UIKit
import ObjectMapper

class userModel: Mappable {
    var provinceName: String?
    var uid: String?
    var signature: String?
    var idCard: String?
    var trueName: String?
    var token: String?
    var cellphone: String?
    
    
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        provinceName <- map["provinceName"]
        uid <- map["uid"]
        signature <- map["signature"]
        idCard <- map["idCard"]
        trueName <- map["trueName"]
        token <- map["token"]
        cellphone <- map["cellphone"]
    }
    
}
