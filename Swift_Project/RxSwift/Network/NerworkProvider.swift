//
//  NerworkProvider.swift
//  ZJSwiftStandDemo
//
//  Created by eafy on 2020/11/11.
//  Copyright © 2020 ZJ. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire
import Moya
import PromiseKit
import CleanJSON

public struct NerworkProvider<Target: NetTargetType> {
    private let disposeBag = DisposeBag()

    private let provider = MoyaProvider<Target>(session: { () -> Session in
        let manager = NetworkSessionManager()
        return manager
    }(), plugins: [NetworkAdapterPlugin(), NetworkLogPlugin()])
    
    init(adapterType: NetworkAdapterPluginType = .json) {
        if let adapter = provider.plugins[0] as? NetworkAdapterPlugin {
            adapter.changeAdapter(adapterType)  //修改适配器类型
        }
    }
}

extension NerworkProvider {
    
    /// 取消所有请求
    public func cancelAll() {
        provider.session.cancelAllRequests()
    }
    
    
}
    
extension NerworkProvider {
    public func requestRaw<T: Codable>(target: Target) -> Promise<T> {
        return Promise { seal in
            provider.rx.request(target, callbackQueue: DispatchQueue.global())
                .subscribeOn(ConcurrentDispatchQueueScheduler(queue: DispatchQueue.global()))
                .map { try $0
                    .filterSuccessfulStatusAndRedirectCodes()
                    .parseServerData()
                    .map(T.self, using: CleanJSONDecoder())
                }
                .observeOn(MainScheduler.instance)
                .subscribe(onSuccess: {
                    seal.fulfill($0)
                }, onError: {
                    seal.reject($0)
                })
                .disposed(by: disposeBag)
        }
    }
    
    public func requestCache<T: Codable>(target: Target) -> Promise<T> {
        if let cache = UserDefaults.standard.value(forKey: target.path) {
            return Promise { seal in
                seal.fulfill(cache as! T)
            }
        } else {
            return Promise { seal in
                provider.rx.request(target, callbackQueue: DispatchQueue.global())
                    .subscribeOn(ConcurrentDispatchQueueScheduler(queue: DispatchQueue.global()))
                    .map { try $0
                        .filterSuccessfulStatusAndRedirectCodes()
                        .parseServerData()
                        .map(T.self, using: CleanJSONDecoder())
                    }
                    .observeOn(MainScheduler.instance)
                    .subscribe(onSuccess: {
                        seal.fulfill($0)
                        UserDefaults.standard.setValue($0, forKey: target.path)
                    } , onError: {
                        seal.reject($0)
                    })
                    .disposed(by: disposeBag)
            }
        }
    }
    
    public func requestString(target: Target) -> Promise<String> {
        return Promise { seal in
            provider.rx.request(target, callbackQueue: DispatchQueue.global())
                .subscribeOn(ConcurrentDispatchQueueScheduler(queue: DispatchQueue.global()))
                .map { try $0
                    .filterSuccessfulStatusAndRedirectCodes()
                    .mapString()
                }
                .observeOn(MainScheduler.instance)
                .subscribe(onSuccess: { seal.fulfill($0)}, onError: { seal.reject($0) })
                .disposed(by: disposeBag)
        }
    }

    public func requestJson(target: Target) -> Promise<Any> {
        return Promise { seal in
            provider.rx.request(target, callbackQueue: DispatchQueue.global())
                .subscribeOn(ConcurrentDispatchQueueScheduler(queue: DispatchQueue.global()))
                .map { try $0
                    .filterSuccessfulStatusAndRedirectCodes()
                    .parseServerData()
                    .mapJSON(failsOnEmptyData: false)
                }
                .observeOn(MainScheduler.instance)
                .subscribe(onSuccess: { seal.fulfill($0)}, onError: { seal.reject($0) })
                .disposed(by: disposeBag)
        }
    }
    
    func requestData(target: Target) -> Promise<Any> {
        return Promise { seal in
            provider.rx.request(target, callbackQueue: DispatchQueue.global())
                .observeOn(ConcurrentDispatchQueueScheduler(queue: DispatchQueue.global()))
                .map { try $0
                    .filterSuccessfulStatusAndRedirectCodes()
                }
                .observeOn(MainScheduler.instance)
                .subscribe(onSuccess: { seal.fulfill($0)}, onError: { seal.reject($0) })
                .disposed(by: disposeBag)
        }
    }
}

extension NerworkProvider {
    
    /// 上传文件
    /// - Parameter target: 触发器
    /// - Returns: 回调监听器
    public func upload<T: Codable>(target: Target) -> Promise<T> {
        return Promise { seal in
            provider.rx.request(target, callbackQueue: DispatchQueue.global())
                .subscribeOn(ConcurrentDispatchQueueScheduler(queue: DispatchQueue.global()))
                .map { try $0
                    .filterSuccessfulStatusAndRedirectCodes()
                    .parseServerData()
                    .map(T.self, using: CleanJSONDecoder())
                }
                .observeOn(MainScheduler.instance)
                .subscribe(onSuccess: {
                    seal.fulfill($0)
                }, onError: {
                    seal.reject($0)
                })
                .disposed(by: disposeBag)
        }
    }
    
    /// 下载文件
    /// - Parameters:
    ///   - url: 文件URL
    ///   - target: 触发器
    /// - Returns: 回调监听器
    public func download(url: String, target: Target) -> Promise<ProgressResponse> {
        return Promise { seal in
            provider.rx.requestWithProgress(target, callbackQueue: DispatchQueue.global())
                .subscribeOn(ConcurrentDispatchQueueScheduler(queue: DispatchQueue.global()))
                .do(onNext: { (response) in
                    debugPrint("do----->\(response)")
                })
                .filterCompleted()
                .observeOn(MainScheduler.instance)
                .subscribe(onNext: { response in
                    debugPrint("onNext----->\(response)")
                }, onError: { response in
                    debugPrint("onError----->\(response)")
                }, onCompleted: {
                    debugPrint("onCompleted----->")
                })
                .disposed(by: disposeBag)

        }
    }
}
