//
//  MusicListViewModel.swift
//  Swift_Project
//
//  Created by jimi01 on 2021/3/25.
//  Copyright © 2021 lvzheng. All rights reserved.
//

import UIKit
import RxSwift

class MusicListViewModel: NSObject {
    var dataSource = Observable.just([
        MusicModel(name: "富士山下", singer: "陈奕迅"),
        MusicModel(name: "白玫瑰", singer: "陈奕迅"),
        MusicModel(name: "灰色轨迹", singer: "Beyond"),
        MusicModel(name: "光辉岁月", singer: "Beyond")
    ])
    
    func updateViewModel() {
        dataSource = Observable.just([
        MusicModel(name: "白玫瑰", singer: "陈奕迅"),
        MusicModel(name: "灰色轨迹", singer: "Beyond"),
        MusicModel(name: "光辉岁月", singer: "Beyond"),
        MusicModel(name: "富士山下", singer: "陈奕迅")
    ])
    }
}
