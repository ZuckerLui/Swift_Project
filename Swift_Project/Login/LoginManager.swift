//
//  CurrentUser.swift
//  Swift_Project
//
//  Created by lvzheng on 2020/4/15.
//  Copyright © 2020 lvzheng. All rights reserved.
//

import UIKit

class LoginManager: NSObject {
    var currentUser: userModel?
    static let share = LoginManager()
    override init() {
        super.init()
    }
}
