//
//  YSendArticelAPI.swift
//  Swift_Project
//
//  Created by lvzheng on 2020/4/11.
//  Copyright © 2020 lvzheng. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

enum YSendArticelAPI {
    case postArticel(params:Dictionary<String, Any>)
    case postNoHud(params:Dictionary<String, Any>)
}

enum YSendArticelPath: String {
    case login = "/sapp/sapp-api/notfilter/member/login"
    case home_banner = "/sapp/sapp-api/banner/getIndexBanner" ///获取首页轮播图片
}

extension YSendArticelAPI: YAPITargetType {
        var method: RequestMed {
            switch self {
            case .postArticel(_):
                return .bodyPost
            case .postNoHud(_):
                return .bodyPost
            default:
                return .get
            }
        }
        
        var baseUrl: String {
            switch self {
            case .postArticel(_):
                return "http://webapi.test.sxmaps.com"
            case .postNoHud(_):
                return "http://webapi.test.sxmaps.com"
            default:
                return "http://webapi.test.sxmaps.com"
            }
            
        }
        
//        var path: String {
//            switch YSendArticelPath(_) {
//            case .login:
//                return "/sapp/sapp-api/notfilter/member/login"
//            default:
//                return "http://webapi.test.sxmaps.com"
//            }
//        }
        
        var pararms: Dictionary<String, Any> {
            switch self {
            case .postArticel(var parprms):
                parprms.updateValue("3.2.0", forKey: "localVersionNo")
                parprms.updateValue(2, forKey: "clientType")
                return parprms
            default:
                return [:]
            }
        }
        
        var isShowHUD: Bool {
            switch self {
            case .postArticel(_):
                return true
            case .postArticel(_):
                return false
            default:
                return true
            }
            
        }
}
