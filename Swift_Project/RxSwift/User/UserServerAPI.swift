//
//  UserServerAPI.swift
//  ZJSwiftStandDemo
//
//  Created by eafy on 2021/3/18.
//  Copyright © 2021 ZJ. All rights reserved.
//

import Foundation
import Moya

enum UserServerAPI {
    case login(account: String, password: String, verCode: String?)
    case logout
}

extension UserServerAPI: NetTargetType {
    
    var path: String {
        switch self {
        case .login:
            return "/reg"
        case .logout:
            return "loginOut"
        }
    }
    
    var paraMaps: [String : Any]? {
        switch self {
        case .login(let account, let password, _):
            let param = [
                "editionType": "1",
                "ver": "4",
                "method": "login",
                "timeZones": "",
                "language": "zh",
                "appType": "0",
                "clientId": "0",
                "mobileType": "3",
                "account": ParamsEncryption.encryptUseDES(account),
                "password": ParamsEncryption.encryptUseDES(password)
            ]
            
            let encryParams = ParamsEncryption.encryptionParams(param) as! [String: Any]
            return encryParams
            
        default:
            return nil
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        switch self {
        case .login:
            return URLEncoding.default            
        default:
            return JSONEncoding.default
        }
    }
}
