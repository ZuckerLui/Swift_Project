//
//  MusicModel.swift
//  Swift_Project
//
//  Created by jimi01 on 2021/3/25.
//  Copyright © 2021 lvzheng. All rights reserved.
//

import UIKit
import HandyJSON

struct MusicModel {
    
    var name: String
    var singer: String
    
    init(name: String, singer: String) {
        self.name = name
        self.singer = singer
    }
}
