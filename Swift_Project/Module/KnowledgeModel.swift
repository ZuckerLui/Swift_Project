//
//  KnowledgeModel.swift
//  Swift_Project
//
//  Created by lvzheng on 2020/9/3.
//  Copyright © 2020 lvzheng. All rights reserved.
//

import UIKit
import HandyJSON

class knowledgeSectionModel: HandyJSON {
    var sectionTitle: String!
    var subModules: Array<KnowledgeModel>?
    required init() {}
    
//    func mapping(mapper: HelpingMapper) {
//        // 指定 subModules 字段用这个方法去解析
//        mapper.specify(property: &subModules) { (rawString) -> Array<KnowledgeModel>? in
//            let models = JSONDeserializer<KnowledgeModel>.deserializeModelArrayFrom(json: rawString) as? [KnowledgeModel]
//            return models
//        }
//    }
}

class KnowledgeModel: HandyJSON {
    var moduleName: String?
    var controllerName: String?
    
    required init() {}
    func mapping(mapper: HelpingMapper) {
        // 指定 controllerName 字段用 "controller" 去解析
        mapper.specify(property: &controllerName, name: "controller")

        // 指定 controllerName 字段用这个方法去解析
//        mapper.specify(property: &controllerName) { (rawString) -> String in
//            let parentNames = rawString.characters.split{$0 == "/"}.map(String.init)
//            return parentNames[0]
//        }
    }
}
