//
//  NetTargetType.swift
//  ZJSwiftStandDemo
//
//  Created by lizhijian on 2020/11/28.
//  Copyright © 2020 ZJ. All rights reserved.
//

import Foundation
import Moya

public protocol NetTargetType: TargetType {
    
    /// 请求模块子API（不需要包含公共头链接部分）
    var path: String { get }
    /// 参数编码类型
    var parameterEncoding: ParameterEncoding { get }
    /// 编码类型类型（一般不需要设置，自适应判断）
    var contentType: NetworkAdapterPluginType { get }
    
    /// Map类型参数
    var paraMaps: [String: Any]? { get }
    /// MultipartFormData类型
    var paraMultFormDatas: [MultipartFormData]? { get }
    /// Data类型
    var paraDatas: Data? { get }
    /// Encodable类型
    var paraEncodable: Encodable? { get }
    
    //MARK:- 下载相关
    
    /// 本地路径
    var localLocation: URL { get }
    /// 文件下载前文件夹路径
    var fileDir: String { get }
    /// 文件名称
    var fileName: String { get }
    /// 下载参数
    var downloadDestination : DownloadDestination? { get }
}

// 请求相关
extension NetTargetType {
    
    /// 主路径
    var baseURL: URL {
        return URL(string: NetworkTools.shared.envServerDomain)!
    }
    
    /// 子路径
    var path: String {
        return ""
    }
    
    var sampleData: Data {
        return "".data(using: .utf8)!
    }
    
    /// 请求方式
    var method: Moya.Method {
        return .post
    }
    
    /// 参数编码类型
    var parameterEncoding: ParameterEncoding {
        return JSONEncoding.default
    }
    
    /// Header中Content-Type类型
    var contentType: NetworkAdapterPluginType {
        return .auto
    }
}
    
extension NetTargetType {
    /// Map类型参数
    var paraMaps: [String: Any]? {
        return nil
    }
    
    /// MultipartFormData类型
    var paraMultFormDatas: [MultipartFormData]? {
        return nil
    }
    
    /// Data类型
    var paraDatas: Data? {
        return nil
    }
    
    /// Encodable类型
    var paraEncodable: Encodable? {
        return nil
    }
    
    /// 请求头参数
    var headers: [String: String]? {
        return nil
    }
}

// 下载相关（method需要重载.get）
extension NetTargetType {
    
    /// 下载文件名称
    var fileName: String {
        return String(Int(Date().timeIntervalSince1970))
    }
    
    /// 下载路径
    var fileDir: String {
        return ""//String.fileDownloadPath
    }
    
    /// 本地完整下载路径
    var localLocation: URL {
        return URL(string: fileDir + fileName)!
    }
    
    /// 是否校验
    public var validate: Bool {
        return false
    }
    
    /// 下载描述
    var downloadDestination: DownloadDestination? {
        return nil
    }
}

extension NetTargetType {
    var task: Task {
        if paraMultFormDatas != nil {
            return .uploadMultipart(paraMultFormDatas!)
        } else if paraDatas != nil {
            return .requestData(paraDatas!)
        } else if paraEncodable != nil {
            return .requestJSONEncodable(paraEncodable!)
        } else if downloadDestination != nil {
            return .downloadDestination(downloadDestination!)
        } else {
            return .requestParameters(parameters: paraMaps ?? [:], encoding: parameterEncoding)
        }
    }
}
