//
//  NetworkMonitor.swift
//  ZJSwiftStandDemo
//
//  Created by eafy on 2020/11/11.
//  Copyright © 2020 ZJ. All rights reserved.
//

import Foundation
import Alamofire

/// 网络变更通知，object为1时表示有网
let kNotificationNetworkDidChange = "kNotificationNetworkDidChange"

public class NetworkMonitor {
    public lazy var reachabilityManager = NetworkReachabilityManager()
    private var preNetworkStatus: NetworkReachabilityManager.NetworkReachabilityStatus?
    private var networkStatus: NetworkReachabilityManager.NetworkReachabilityStatus = .unknown
    
    class var shared : NetworkMonitor {
        struct Static {
            static let instance = NetworkMonitor()
        }
        return Static.instance
    }
    
    /// 开启监听
    func start() {
        reachabilityManager?.startListening(onUpdatePerforming: { [weak self] (status) in
            if let networkStatus = self?.networkStatus {
                self?.preNetworkStatus = self?.preNetworkStatus == nil ? status : networkStatus
            }
            self?.networkStatus = status
            
            switch status {
            case .reachable(_):
                print("Network is reachable")
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: kNotificationNetworkDidChange), object: 1)
            case .notReachable:
                print("Network is not Reachable!")
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: kNotificationNetworkDidChange), object: 0)
            default:
                print("Network is unknow status!")
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: kNotificationNetworkDidChange), object: 0)
            }
        })
    }
    
    /// 停止监听
    func stop() {
        reachabilityManager?.stopListening()
    }
    
    /// 判断是否有网
    /// - Returns: true：有网
    func isReachability() -> Bool {
        return (reachabilityManager?.isReachable)!
    }
    
    /// 前后2次网络是否相同
    /// - Returns: true：相同，false：不相同
    func isSameNetwork() -> Bool {
        return preNetworkStatus == networkStatus
    }
}
