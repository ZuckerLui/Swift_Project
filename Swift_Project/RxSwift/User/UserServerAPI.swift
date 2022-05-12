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
            return ""
        case .logout:
            return ""
        }
    }
    
    var paraMaps: [String : Any]? {
        switch self {
        case .login(let account, let password, _):
            let param = [
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
