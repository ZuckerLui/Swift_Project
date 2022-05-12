//
//  MusicListViewModel.swift
//  Swift_Project
//
//  Created by lz on 2021/3/25.
//  Copyright © 2021 lvzheng. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources

struct MusicListViewModel {
    var dataArray = Array<SectionModel<MusicSectionModel, MusicModel>>()
    
    mutating func initDataArray() -> Observable<[SectionModel<MusicSectionModel, MusicModel>]> {
        dataArray = [
            SectionModel(model: MusicSectionModel(area: "港台", bgColor: .orange), items: [
                MusicModel(name: "富士山下", singer: "陈奕迅"),
                MusicModel(name: "十一月的肖邦", singer: "周杰伦"),
                MusicModel(name: "灰色轨迹", singer: "Beyond")
            ]),
            SectionModel(model: MusicSectionModel(area: "大陆", bgColor: .blue), items: [
                MusicModel(name: "一无所有", singer: "催健"),
                MusicModel(name: "曾经的你", singer: "许巍"),
                MusicModel(name: "成都", singer: "赵雷")
            ])
        ]
        let  result = Observable.just(dataArray)
        return result
    }
    
    mutating func updateDataArray () -> Observable<[SectionModel<MusicSectionModel, MusicModel>]>{
        dataArray = [
            SectionModel(model: MusicSectionModel(area: "港台", bgColor: .orange), items: [
                MusicModel(name: "富士山下", singer: "陈奕迅"),
                MusicModel(name: "十一月的肖邦", singer: "周杰伦"),
                MusicModel(name: "灰色轨迹", singer: "Beyond")
            ]),
            SectionModel(model: MusicSectionModel(area: "大陆", bgColor: .blue), items: [
                MusicModel(name: "一无所有", singer: "催健"),
                MusicModel(name: "曾经的你", singer: "许巍"),
                MusicModel(name: "成都", singer: "赵雷")
            ]),
            SectionModel(model: MusicSectionModel(area: "日韩", bgColor: .blue), items: [
                MusicModel(name: "世界的尽头", singer: "???"),
                MusicModel(name: "If You", singer: "???")
            ])
        ]
        let  result = Observable.just(dataArray)
        return result
    }
}
