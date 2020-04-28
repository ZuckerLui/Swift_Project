//
//  GlobalMacro.swift
//  Swift_Project
//
//  Created by lvzheng on 2020/4/7.
//  Copyright © 2020 lvzheng. All rights reserved.
//

import UIKit
import SnapKit

class GlobalMacro: NSObject {

}

enum ScreenSize {
    static let width = UIScreen.main.bounds.size.width
    static let height = UIScreen.main.bounds.size.height
    static let statusBarHeight = UIApplication.shared.statusBarFrame.height
}
