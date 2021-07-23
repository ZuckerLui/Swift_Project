//
//  NetworkLogPlugin.swift
//  ZJSwiftStandDemo
//
//  Created by eafy on 2020/11/11.
//  Copyright © 2020 ZJ. All rights reserved.
//

import Foundation
import Moya

public final class NetworkLogPlugin: PluginType {
    
    public func willSend(_ request: RequestType, target: TargetType) {
//        guard openNetRequestLog != 0 else {  return  }
        #if DEBUG
        print("请求---->>>>>>")
        print(request.request?.url ?? "Error: request url is unkown!")
        print(request.request?.allHTTPHeaderFields ?? "")
        if let netTarget = target as? NetTargetType, let paraMaps = netTarget.paraMaps {
            print(paraMaps)
        }
        #endif
    }
    
    public func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
//        guard openNetRequestLog != 0 else {  return  }
        #if DEBUG
        switch result {
        case .success(let response):
            do {
                printRequestInfo(response, target: target)
                print(try response.mapString())
            } catch {
                print(error)
            }
        case .failure(let error):
            printRequestInfo(error.response, target: target)
            print(error)
        }
        print("")
        #endif
    }
    
    private func printRequestInfo(_ response: Response?, target: TargetType) {
        print("回复---->>>>>>")
        print(response?.request?.url ?? "Error: request url is unkown!")
    }
}
