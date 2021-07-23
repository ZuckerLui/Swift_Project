//
//  NetworkManager.swift
//  Swift_Project
//
//  Created by jimi01 on 2021/4/29.
//  Copyright © 2021 lvzheng. All rights reserved.
//

import UIKit

class NetworkTools: NSObject {
    static let shared = NetworkTools()
    
    let envServerDomain = "http://tujunsat.jimicloud.com/api"
    
    private override init () {
        
    }
}
