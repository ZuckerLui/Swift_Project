//
//  NetworkSessionManager.swift
//  ZJSwiftStandDemo
//
//  Created by eafy on 2020/11/11.
//  Copyright © 2020 ZJ. All rights reserved.
//

import Foundation
import Alamofire

final public class NetworkSessionManager: Session {
    static private let kNetworkStopAllTaskNotification = "kNetworkStopAllTaskNotification"
    
    public init(configuration: URLSessionConfiguration = URLSessionConfiguration.af.default,
                delegate: SessionDelegate = SessionDelegate(),
                rootQueue: DispatchQueue = DispatchQueue(label: "org.alamofire.session.rootQueue"))
    {
//        configuration.timeoutIntervalForRequest = 15
//        configuration.timeoutIntervalForResource = 60

        let delegateQueue = OperationQueue()
        delegateQueue.maxConcurrentOperationCount = 1
        delegateQueue.underlyingQueue = rootQueue
        delegateQueue.name = "org.alamofire.session.sessionDelegateQueue"
        let session = URLSession(configuration: configuration, delegate: delegate, delegateQueue: delegateQueue)

        super.init(session: session, delegate: delegate, rootQueue: rootQueue, startRequestsImmediately: true, requestQueue: nil, serializationQueue: nil, interceptor: nil, serverTrustManager: nil, redirectHandler: nil, cachedResponseHandler: nil, eventMonitors: [])

        NotificationCenter.default.addObserver(self, selector: #selector(stopAllTask), name:  NSNotification.Name(rawValue: NetworkSessionManager.kNetworkStopAllTaskNotification), object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func stopAllTask(_ noti: NSNotification) {
        cancelAllRequests()
    }
    
    func serverTrust(session: URLSession, challenge: URLAuthenticationChallenge) -> (URLSession.AuthChallengeDisposition, URLCredential?) {
        return (URLSession.AuthChallengeDisposition.useCredential, URLCredential(trust: challenge.protectionSpace.serverTrust!))
    }
}

extension NetworkSessionManager {
    
    /// 取消所有网络提供器的请求
    static func cancelAll() {
        NotificationCenter.default.post(name: Notification.Name(rawValue: NetworkSessionManager.kNetworkStopAllTaskNotification), object: nil)
    }
}
