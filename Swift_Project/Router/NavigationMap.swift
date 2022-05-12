//
//  NavigationRouter.swift
//  Swift_Project
//
//  Created by lz on 2021/5/8.
//  Copyright © 2021 lvzheng. All rights reserved.
//

import UIKit
import URLNavigator

enum NavigationMap {
    // 注入navigator，进行注册所有需要操作的URL路径
    static func initialize(navigator: NavigatorType) {
        navigator.register("navigator://userInfo/<titleName>") { url, values, context in
            guard let titleName = values["titleName"] as? String else {
                return nil
            }
            
            return UserInfoViewController(navigator: navigator, titleName: titleName, userInfo: context as? UserInfo)
        }
        
//        navigator.register("http://<path:_>", self.webViewControllerFactory)
//        navigator.register("https://<path:_>", self.webViewControllerFactory)
        
        navigator.handle("navigator://alert", self.alert(navigator: navigator))
        navigator.handle("navigator://<path:_>") { (url, values, context) -> Bool in
            // No navigator match, do analytics or fallback function here
            print("[Navigator] NavigationMap.\(#function):\(#line) - global fallback function is called")
            return true
        }
    }
        
//    private static func webViewControllerFactory(
//        url: URLConvertible,
//        values: [String: Any],
//        context: Any?
//    ) -> UIViewController? {
//        guard let url = url.urlValue else { return nil }
//        return SFSafariViewController(url: url)
//    }
    
    private static func alert(navigator: NavigatorType) -> URLOpenHandlerFactory {
        return { url, values, context in
            guard let title = url.queryParameters["title"] else { return false }
            let message = url.queryParameters["message"]
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            navigator.present(alertController)
            return true
        }
    }
}
