//
//  NerworkProviderError.swift
//  ZJSwiftStandDemo
//
//  Created by eafy on 2020/11/11.
//  Copyright © 2020 ZJ. All rights reserved.
//

import Foundation

enum NerworkProviderError: Swift.Error {
    case ErrorParse
    case ErrorServerError(code: Int, message: String)
    case ErrorData(code: Int, message: String, data:[String:Any])
}

extension NerworkProviderError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .ErrorParse:
            return "数据解析错误"
        case .ErrorServerError(_, let message):
            return message
        case .ErrorData(_, let message, _):
            return message
        }
    }
}
