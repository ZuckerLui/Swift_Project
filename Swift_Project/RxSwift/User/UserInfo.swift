//
//  UserInfo.swift
//  ZJSwiftStandDemo
//
//  Created by eafy on 2020/11/12.
//  Copyright © 2020 ZJ. All rights reserved.
//

import Foundation

enum UserTypeEnum: String, Codable {
    case admin = "0"    //管理员
    case endUser = "3"  //终端用户
    case agent = "8"    //代理商
    case user = "9"     //用户
    case distributor = "10"  //分销商
    case sales = "11"  //销售
    case experience = "12" //体验账户
    
    /// 是否允许切换服务器
    /// - Returns: true，允许
    func isSwitchNodeEnable() -> Bool {
        switch self {
        case .admin, .sales:
            return true
        default:
            return false
        }
    }
}

struct UserInfo: Codable {
    /// 账号
    var account: String?
    var companyName: String?
    var email: String?
    let updateFlag: Int?
    var isPermitted: Bool?
    var language: String?
    /// 用户User ID
    var id: String?
    var onlineNum: String?
    var parentFlag: String?
    /// 节点服务器地址
    var phone: String?
    var timeZones: String?
    /// 容量单位
    var type: String?
    
    var fictitiousAccount: FicAccount
}

struct FicAccount: Codable {
    let account: String?
    let instructionsFlag: Int?
    let parent: String?
    let updateFlag: Int?
}
