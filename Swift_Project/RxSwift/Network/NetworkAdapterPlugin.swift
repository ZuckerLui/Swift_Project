//
//  NetworkAdapterPlugin.swift
//  ZJSwiftStandDemo
//
//  Created by eafy on 2021/1/31.
//  Copyright © 2021 ZJ. All rights reserved.
//

import Foundation
import Moya

public enum NetworkAdapterPluginType {
    case auto           // 自动识别
    case json           // application/json
    case multForm       // application/x-www-form-urlencoded
    case multipart      // multipart/form-data
}

public final class NetworkAdapterPlugin: PluginType {
    private var adapterType: NetworkAdapterPluginType = .json       //全局适配器类型
    
    init(adapterType: NetworkAdapterPluginType = .json) {
        self.adapterType = adapterType
    }
    
    /// 更改适配器类型
    /// - Parameter type: 请求类型
    public func changeAdapter(_ type: NetworkAdapterPluginType) {
        self.adapterType = type
    }
    
    public func prepare(_ request: URLRequest, target: NetTargetType) -> URLRequest {
        var request = request
        request.setValue(String(UIDevice.current.model) + "_" + String(UIDevice.current.systemVersion), forHTTPHeaderField: "User-Agent")
        request.setValue("ios", forHTTPHeaderField: "Client-Type")
        
        var adapterType = self.adapterType
        if target.contentType != .auto {
            adapterType = target.contentType
        }
        
        switch adapterType {
        case .json:
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        case .multForm:
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        default:break
        }
        
        return request
    }
}
