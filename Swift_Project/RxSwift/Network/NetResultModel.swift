//
//  NetResultModel.swift
//  ZJSwiftStandDemo
//
//  Created by eafy on 2020/11/25.
//  Copyright © 2020 ZJ. All rights reserved.
//

import Foundation

/// 网络请求返回通用Model
struct NetResultModel<T: Codable>: Codable {

    let code: Int
    let msg: String
    let data: T
    
    enum CodingKeys: String, CodingKey {
        case code = "code"
        case msg = "msg"
        case data = "data"
    }
}

/// 空类型返回T Model
struct NetResultdata: Codable {
    let reserve: String?
}
