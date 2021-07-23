//
//  LoginValidViewModel.swift
//  Swift_Project
//
//  Created by jimi01 on 2021/3/30.
//  Copyright © 2021 lvzheng. All rights reserved.
//

import UIKit
import RxSwift

class LoginValidViewModel: NSObject {

    let userNameValid: Observable<Bool>!
    let passwordValid: Observable<Bool>!
    let everythingValid: Observable<Bool>!
    
    init(_ userName: Observable<String>,
         _ password: Observable<String>) {
        userNameValid = userName
                            .map { $0.count >= 6 }
            .share(replay: 1, scope: .whileConnected)
        
        passwordValid = password
                            .map({ (text) -> Bool in
                                return text.count >= 6
                            }).share(replay: 1, scope: .whileConnected)
                            
        
        everythingValid = BehaviorSubject.combineLatest(userNameValid, passwordValid, resultSelector: { (uValid, pValid) -> Bool in
            return uValid && pValid
        }).share(replay: 1, scope: .forever)
    }
}
