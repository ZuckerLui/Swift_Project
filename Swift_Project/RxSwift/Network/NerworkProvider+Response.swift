//
//  NerworkProvider+Response.swift
//  ZJSwiftStandDemo
//
//  Created by eafy on 2020/11/11.
//  Copyright © 2020 ZJ. All rights reserved.
//

import Foundation
import RxSwift
import Moya

extension Response {
    
    func parseServerData() throws -> Response {
        do {
            let responseJson = try self.mapJSON(failsOnEmptyData: false)
            guard let dict = responseJson as? [String: Any] else { throw NerworkProviderError.ErrorParse }
            if let error = self.praseDataError(dict: dict) { throw error }
            return self
        } catch {
            throw error
        }
    }
    
    func praseDataError(dict: [String: Any]) -> Error? {
        
        if var code = dict[NetResultModel<NetResultdata>.CodingKeys.code.rawValue] as? Int, ![0,200].contains(code) {
            let message = dict[NetResultModel<NetResultdata>.CodingKeys.msg.rawValue] as? String
            code = handleSpecialErrCode(code: code, message: message)
            if code == -1 {     //特殊码返回data数据
                if let data = dict[NetResultModel<NetResultdata>.CodingKeys.data.rawValue] as? [String:Any] {
                    return NerworkProviderError.ErrorData(code:code, message: message ?? "", data: data)
                }
            }
            return NerworkProviderError.ErrorServerError(code: code, message: message ?? "")
        }
        
        return nil
    }
    
    /// 特殊状态码处理
    /// - Parameters:
    ///   - code: 状态码
    ///   - message: 状态消息
    func handleSpecialErrCode(code: Int, message: String?) -> Int {
        switch code {
            case 405: break
            
            default:break
        }
        return code
    }
    
    func catchBestDomain() -> Response {
        return self
    }
}
