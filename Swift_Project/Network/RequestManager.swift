//
//  RequestManager.swift
//  Swift_Project
//
//  Created by lvzheng on 2020/4/9.
//  Copyright © 2020 lvzheng. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import ObjectMapper

//成功
typealias NetSuccessBlock<T: Mappable> = (_ value: NetWorkBaseModel<T>, JSON) -> Void
//失败
typealias NetFailedBlock = (AFSErrorInfo) -> Void
typealias AFSProgressBlock = (Double) -> Void//进度

class RequestManager: NSObject {
    private var sessionManager : SessionManager?
    static let share = RequestManager()
    override init() {
        super.init()
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 15
        sessionManager = SessionManager.init(configuration: configuration, delegate: SessionDelegate.init(), serverTrustPolicyManager: nil)
    }
}

/** 外部调用方法 */
extension RequestManager {
    func requestByTargetType<T: Mappable>(targetType: YAPITargetType,
                                          path: YSendArticelPath,
                                          model: T.Type,
                                          success: @escaping NetSuccessBlock<T>,
                                          failed: @escaping NetFailedBlock) -> Void {
        let url = targetType.baseUrl + path.rawValue
            switch targetType.method {
            case .get:
                self.GET(url: url, param: targetType.pararms, isShowHUD: targetType.isShowHUD, success: success, failed: failed)
                break
            case .post:
                self.POST(url: url, param: targetType.pararms, isShowHUD: targetType.isShowHUD, success: success, failed: failed)
                break
            case .bodyPost:
                self.POST(url: url, paramBody: targetType.pararms, isShowHUD: targetType.isShowHUD, success: success, failed: failed)
                break
            default:
                break
            }
        }
}

/** 封装请求方法 */
extension RequestManager {
    fileprivate func GET<T: Mappable>(url: String,
                                      param: Parameters?,
                                      isShowHUD: Bool,
                                      success: @escaping NetSuccessBlock<T>,
                                      failed: @escaping NetFailedBlock) -> Void {
    //        let encodStr = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            if isShowHUD {
                SVProgressHUD.show()
            }
        
            var headers: HTTPHeaders {
                if let user = LoginManager.share.currentUser {
                   return ["Content-Type":"application/json;charset=utf-8", "token": user.token ?? ""]
                }
                return ["Content-Type":"application/json;charset=utf-8"]
            }
            self.sessionManager?.request(url, method: .get, parameters: param, encoding: URLEncoding.httpBody , headers: headers).validate().responseJSON(completionHandler: { (response) in
            
                SVProgressHUD.dismiss()
                self.handleResponse(response: response, successBlock: success, faliedBlock: failed)
            })
        }
    
    fileprivate func POST<T: Mappable>(url: String,
                                       param: Parameters?,
                                       isShowHUD: Bool,
                                       success: @escaping NetSuccessBlock<T>,
                                       failed: @escaping NetFailedBlock) -> Void {
            //let encodStr = url.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed);
            
            
            var headers: HTTPHeaders {
                if let user = LoginManager.share.currentUser {
                   return ["Content-Type":"application/json;charset=utf-8", "token": user.token ?? ""]
                }
                return ["Content-Type":"application/json;charset=utf-8"]
            }
            // http
            if isShowHUD {
                let keyViewController = UIApplication.shared.keyWindow?.rootViewController
                if (keyViewController != nil) {
//                    MBProgressHUD.showAdded(to: keyViewController!.view, animated: true)
                    SVProgressHUD.show()
                }
            }
            self.sessionManager!.request(url, method: HTTPMethod.post, parameters: param, encoding: URLEncoding.httpBody, headers: headers)
                .validate()
                .responseJSON(completionHandler: { (response) in
                    let keyViewController = UIApplication.shared.keyWindow?.rootViewController
                    if (keyViewController != nil) {
                        SVProgressHUD.dismiss()
//                        MBProgressHUD.hide(for: keyViewController!.view, animated: true)
                    }
                    self.handleResponse(response: response, successBlock: success, faliedBlock: failed)
                })
        }
    
    //    内容放在body里面
        func POST<T: Mappable>(url: String,
                               paramBody: Dictionary<String, Any>?,
                               isShowHUD: Bool,
                               success: @escaping NetSuccessBlock<T>,
                               failed: @escaping NetFailedBlock) -> Void {
            //let encodStr = url.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed);
            if isShowHUD {
                SVProgressHUD.show()
            }
            let json = JSON.init(paramBody as Any)
            let urlReqest = URL.init(string: url)
            var request = URLRequest.init(url: urlReqest!)
            request.httpMethod = HTTPMethod.post.rawValue
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            if let user = LoginManager.share.currentUser {
                request.setValue(user.token ?? "", forHTTPHeaderField: "token")
            }
            request.httpBody = json.description.data(using: .utf8)

            self.sessionManager!.request(request)
                .validate()
                .responseJSON(completionHandler: { (response) in
                    self.handleResponse(response: response, successBlock: success, faliedBlock: failed)
                    SVProgressHUD.dismiss()
                })
        }
}

/** 返回数据的处理 */
extension RequestManager {
    /** 处理服务器响应数据*/
    private func handleResponse<T: Mappable>(response: DataResponse<Any>, successBlock: NetSuccessBlock<T> ,faliedBlock: NetFailedBlock){
        if let error = response.result.error {
            // 服务器未返回数据
            self.handleRequestError(error: error as NSError , faliedBlock: faliedBlock)
            
        }else if let value = response.result.value {
            // 服务器有返回数数据
            if (value as? NSDictionary) == nil {
                // 返回格式不对
                self.handleRequestSuccessWithFaliedBlcok(faliedBlock: faliedBlock)
            }else{
                self.handleRequestSuccess(value: value, successBlock: successBlock, faliedBlock: faliedBlock);
            }
        }
    }
    
    /** 处理请求失败数据*/
    private func handleRequestError(error: NSError, faliedBlock: NetFailedBlock){
        var errorInfo = AFSErrorInfo();
        errorInfo.code = error.code;
        errorInfo.error = error;
        if ( errorInfo.code == -1009 ) {
            errorInfo.message = "无网络连接";
        }else if ( errorInfo.code == -1001 ){
            errorInfo.message = "请求超时";
        }else if ( errorInfo.code == -1005 ){
            errorInfo.message = "网络连接丢失(服务器忙)";
        }else if ( errorInfo.code == -1004 ){
            errorInfo.message = "服务器没有启动";
        }else if ( errorInfo.code == 404 || errorInfo.code == 3) {
        }
        faliedBlock(errorInfo)
    }
    
     /** 处理请求成功数据*/
    private func handleRequestSuccess<T: Mappable>(value:Any, successBlock: NetSuccessBlock<T>,faliedBlock: NetFailedBlock){
        let json: JSON = JSON(value);
        let baseModel = NetWorkBaseModel<T>.init(JSONString: json.description)
        if baseModel?.code == 200 {
            successBlock(baseModel!, json)
        } else { // 获取服务器返回失败原因
            var errorInfo = AFSErrorInfo();
            errorInfo.code = baseModel!.code!;
            errorInfo.message = baseModel?.text ?? "未知错误";
            faliedBlock(errorInfo);
        }
    }
    
    /** 服务器返回数据解析出错*/
    private func handleRequestSuccessWithFaliedBlcok(faliedBlock: NetFailedBlock){
        var errorInfo = AFSErrorInfo();
        errorInfo.code = -1;
        errorInfo.message = "数据解析出错";
    }
}

/** 访问出错具体原因 */
struct AFSErrorInfo {
    var code = 0
    var message: String!
    var error = NSError()
}

public protocol YAPITargetType {
    var method: RequestMed {get}
    
    var baseUrl: String { get }
    
//    var path: String { get }
    
    var pararms: Dictionary<String, Any>{get}
    
    var isShowHUD: Bool {get}
}

public enum RequestMed: Int {
    case post = 0
    case get = 1
    case bodyPost = 2
    case uploadImage = 3
    case uploadMp4 = 4
}
