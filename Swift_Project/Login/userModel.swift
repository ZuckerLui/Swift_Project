//
//  userModel.swift
//  Swift_Project
//
//  Created by lvzheng on 2020/4/12.
//  Copyright © 2020 lvzheng. All rights reserved.
//

import UIKit
import HandyJSON

class UserModel: HandyJSON {
    var provinceName: String?
    var uid: String?
    var signature: String?
    var idCard: String?
    var trueName: String?
    var token: String?
    var cellphone: String?
    var ID: String?
    var mapTest: String?
    
    required init() {
        
    }
    
    func mapping(mapper: HelpingMapper) {
        mapper <<<
            self.ID <-- "id"
        mapper <<<
            self.mapTest <-- "maptest"
    }
    
}
