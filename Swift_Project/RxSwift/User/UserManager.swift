//
//  UserManager.swift
//  ZJSwiftStandDemo
//
//  Created by eafy on 2021/3/18.
//  Copyright © 2021 ZJ. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import PromiseKit
import CleanJSON

@objc class UserManager: NSObject {
    @objc public static let shared = UserManager()
    /// 请求使用
    public let provider = NerworkProvider<UserServerAPI>()
    
    /// 当前账号信息
//    public var accountInfo = BehaviorRelay<AccountInfo>(value: AccountInfo())
    /// 用户信息
//    public var userInfo = BehaviorRelay<UserInfo?>(value: nil)
    var userInfo: UserInfo?
    /// 选择的节点
//    public var selectServerUrl: String? = "https://hk.tracksolidpro.com"
    
    /// 清除数据
    /// - Parameter isClearAcc: 是否清除用户账号信息
    @objc func clear(isClearAcc: Bool = true) {
//        if isClearAcc {
//            Defaults[.account] = nil
//            Defaults[.password] = nil
//            accountInfo.accept(AccountInfo())
//        }
//        userInfo.accept(nil)
    }
    
    /// 更新账号和用户信息
    /// - Parameters:
    ///   - acc: 账号
    ///   - pwd: 密码
    ///   - data: 用户信息数据
    @objc func updateUser(acc: String, pwd: String, _ userInfoMap: [String:Any]?) {
//        var accInfo = AccountInfo()
//        accInfo.account = acc
//        accInfo.password = pwd
//        accountInfo.accept(accInfo)
        
        guard let userInfoMap = userInfoMap else { return }
        let info = try? CleanJSONDecoder().decode(UserInfo.self, from: userInfoMap)
//        userInfo.accept(info)
//        AppConfig.shared.router.open(.initDefaultData)
    }
}

extension UserManager {
    
    /// 登录
    /// - Parameters:
    ///   - account: 账号
    ///   - password: 密码
    ///   - verifyCode: 短信验证码
    ///   - completion: 回调
    func login(account: String, password: String, verifyCode: String, completion: ((Error?) -> Void)?) {
        provider.cancelAll()
        
        let promise: Promise<NetResultModel<UserInfo>> = provider.requestRaw(target: .login(account: account, password: password, verCode: ""))
        promise.done { [weak self] result in
            
            self?.userInfo = result.data
//            let nodeUrl = result.data.nodeUrl! + "/api"
//            if self?.selectServerUrl == nil, nodeUrl.count > 4 && nodeUrl != NetworkTools.shared.envServerDomain {  //自动切换
//                NetworkTools.shared.switchDefaultServerEnv(type: nil, server: nodeUrl)
//                self?.login(account: account, password: password, verifyCode: verifyCode, completion: completion)
//            } else {
//                var accountInfo = AccountInfo()
//                accountInfo.account = account;
//                accountInfo.password = password
//                UserManager.shared.accountInfo.accept(accountInfo)
//                UserManager.shared.userInfo.accept(result.data)
//                AppConfig.shared.router.open(.initDefaultData)
                completion?(nil)
//            }
        }.catch { error in
            debugPrint("Account：\(account)")
            debugPrint("Password：\(password)")
            error.show()
            completion?(error)
        }
    }
    
    /// 登出
    /// - Parameter isAutoLogout: 是否自动登出
    /// - Parameter gotoRegister: 是否跳转注册页
    /// - Parameter completion: 回调
    func logout(isAutoLogout: Bool = false, completion: ((Error?) -> Void)? = nil) {
        provider.cancelAll()
//        guard UserManager.shared.userInfo.value != nil else { return }
        if !isAutoLogout {
//            ZJProgressHUD.message("登出中...")
        }
        
        let str = "您的账号已在其他地方登录！"
        let promise: Promise<NetResultModel<NetResultdata>> = provider.requestRaw(target: .logout)
        promise.done { result in
//            if isAutoLogout {
//                ZJProgressHUD.error(withTitle: str, duration: 3)
//            } else {
//                ZJProgressHUD.dismiss()
//            }
//
//            Defaults[.isAutoLogout] = isAutoLogout
//            AppConfig.shared.router.open(.clearDefaultData)
//            AppConfig.shared.router.open(.userLogin)
            completion?(nil)
        }.catch { error in
//            if isAutoLogout {
//                ZJProgressHUD.error(withTitle: str, duration: 3)
//            } else {
//                ZJProgressHUD.dismiss()
//            }
//            Defaults[.isAutoLogout] = isAutoLogout
//            AppConfig.shared.router.open(.clearDefaultData)
//            AppConfig.shared.router.open(.userLogin)
        }
    }
}
