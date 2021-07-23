//
//  Network+Error.swift
//  ZJSwiftStandDemo
//
//  Created by eafy on 2020/11/28.
//  Copyright © 2020 ZJ. All rights reserved.
//

import Foundation
import Moya
import Alamofire

extension Error {
    
    func show(_ msg: String? = nil, _ code: Int? = nil) {
//        let msgStr = msg ?? defaultErrorDescription
//        guard msgStr.count > 0 else { return }
//        let codeValue = code ?? httpCode
//
//        ZJProgressHUD.error(withTitle: msgStr + "[\(codeValue)]", duration: 1.5)
    }
    
    func showLocalized() {
//        let msg = "ret_code_\(httpCode)".localized("")
//        guard msg.count > 0 else { return }
//        ZJProgressHUD.error(withTitle: msg + "[\(httpCode)]", duration: 1.5)
    }
}

extension Swift.Error {
    public var defaultErrorDescription: String {
        if let `self` = self as? MoyaError {
            return self.defaultErrorDescription
        } else {
            guard (self as NSError).code != -1009 else {
                return "当前网络异常，请检查您的网络"
            }
            return self.localizedDescription
        }
    }

    public var data:[String:Any]? {
        if let `self` = self as? NerworkProviderError {
            switch self  {
            case .ErrorData(_,_,let data):
                return  data
            default:
                return nil
            }
        }
        return nil
    }
    
    public var isCancledType: Bool {
        var result = false
        if let `self` = self as? MoyaError {
            switch self {
            case .underlying(let error, _):
                if (error as NSError).code == -999 {
                    result = true
                }
            default: break
            }
        }
        return result
    }
    
    public var httpCode: Int{
        if let `self` = self as? MoyaError {
            switch self{
            case MoyaError.imageMapping(let response):
                return response.statusCode
            case MoyaError.jsonMapping(let response):
                return response.statusCode
            case MoyaError.stringMapping(let response):
                return response.statusCode
            case MoyaError.objectMapping(_, let response):
                return response.statusCode
            case MoyaError.statusCode(let response):
                return response.statusCode
            case MoyaError.underlying(let error, let response):
                if let err = (error as? AFError) {
                    switch err {
                    case .sessionTaskFailed(let err):
                        return (err as NSError).code
                    default:break
                    }
                }
                return response?.statusCode ?? 999
            default:
                return 999
            }
        } else if let `self` = self as? NerworkProviderError {
            switch self{
            case .ErrorServerError(let code, _):
                return code
            case .ErrorData(let code,_,_):
                return code
            default:
                return (self as NSError).code
            }
        } else {
            return (self as NSError).code
        }
    }
}

extension MoyaError {
    public var defaultErrorDescription: String {
        switch self {
        case MoyaError.imageMapping:
            print ("请求异常(数据解析失败).")
        case MoyaError.jsonMapping:
            print ("请求异常(Json解析失败).")
        case MoyaError.stringMapping:
            print ("请求异常(数据解析失败).")
        case MoyaError.objectMapping(_, _):
            print ("请求异常(数据解析失败).")
        case MoyaError.encodableMapping:
            print ("Model转Data失败.")
        case MoyaError.statusCode( _):
            return "网络环境较差，请您稍后重试"
        case MoyaError.requestMapping:
            print ("Failed to map Endpoint to a URLRequest.")
        case MoyaError.parameterEncoding(let error):
            print("Failed to encode parameters for URLRequest. \(error.localizedDescription)")
        case MoyaError.underlying(_, _):
            return "网络环境较差，请您稍后重试"
        }
        return "网络环境较差，请您稍后重试"
    }
}

extension AFError {
    
    /// 获取错误码
    /// - Returns: 失败错误码
    func failedCode() -> Int {
        switch self {
        case .sessionTaskFailed(let err):
           return (err as NSError).code
        default:
            return responseCode ?? 999
        }
    }
}

/*
typedef enum
{
NSURLErrorUnknown = -1,   // "无效的URL地址"
NSURLErrorCancelled = -999,  // "无效的URL地址"
NSURLErrorBadURL = -1000,  // "无效的URL地址"
NSURLErrorTimedOut = -1001,  // "网络不给力，请稍后再试"
NSURLErrorUnsupportedURL = -1002,  // "不支持的URL地址"
NSURLErrorCannotFindHost = -1003,  // "找不到服务器"
NSURLErrorCannotConnectToHost = -1004,  // "连接不上服务器"
NSURLErrorDataLengthExceedsMaximum = -1103,  // "请求数据长度超出最大限度"
NSURLErrorNetworkConnectionLost = -1005,  // "网络连接异常"
NSURLErrorDNSLookupFailed = -1006,  // "DNS查询失败"
NSURLErrorHTTPTooManyRedirects = -1007,  // "HTTP请求重定向"
NSURLErrorResourceUnavailable = -1008,  // "资源不可用"
NSURLErrorNotConnectedToInternet = -1009,  // "无网络连接"
NSURLErrorRedirectToNonExistentLocation = -1010,  // "重定向到不存在的位置"
NSURLErrorBadServerResponse = -1011,  // "服务器响应异常"
NSURLErrorUserCancelledAuthentication = -1012,  // "用户取消授权"
NSURLErrorUserAuthenticationRequired = -1013,  // "需要用户授权"
NSURLErrorZeroByteResource = -1014,  // "零字节资源"
NSURLErrorCannotDecodeRawData = -1015,  // "无法解码原始数据"
NSURLErrorCannotDecodeContentData = -1016,  // "无法解码内容数据"
NSURLErrorCannotParseResponse = -1017,  // "无法解析响应"
NSURLErrorInternationalRoamingOff = -1018, // "国际漫游关闭"
NSURLErrorCallIsActive = -1019, // "被叫激活"
NSURLErrorDataNotAllowed = -1020, // "数据不被允许"
NSURLErrorRequestBodyStreamExhausted = -1021, // "请求体"
NSURLErrorFileDoesNotExist = -1100,  // "文件不存在"
NSURLErrorFileIsDirectory = -1101,  // "文件是个目录"
NSURLErrorNoPermissionsToReadFile = -1102,  // "无读取文件权限"
NSURLErrorSecureConnectionFailed = -1200,  // "安全连接失败"
NSURLErrorServerCertificateHasBadDate = -1201,  // "服务器证书失效"
NSURLErrorServerCertificateUntrusted = -1202, // "不被信任的服务器证书"
NSURLErrorServerCertificateHasUnknownRoot = -1203,  // "未知Root的服务器证书"
NSURLErrorServerCertificateNotYetValid = -1204,  // "服务器证书未生效"
NSURLErrorClientCertificateRejected = -1205,  // "客户端证书被拒"
NSURLErrorClientCertificateRequired = -1206,  // "需要客户端证书"
NSURLErrorCannotLoadFromNetwork = -2000,  // "无法从网络获取"
NSURLErrorCannotCreateFile = -3000,  // "无法创建文件"
NSURLErrorCannotOpenFile = -3001,  // "无法打开文件"
NSURLErrorCannotCloseFile = -3002,  // "无法关闭文件"
NSURLErrorCannotWriteToFile = -3003,  // "无法写入文件"
NSURLErrorCannotRemoveFile = -3004, // "无法删除文件"
NSURLErrorCannotMoveFile = -3005,  // "无法移动文件"
NSURLErrorDownloadDecodingFailedMidStream = -3006,  // "下载解码数据失败"
NSURLErrorDownloadDecodingFailedToComplete = -3007  // "下载解码数据失败"
}
*/
