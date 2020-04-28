//
//  DataBaseManager.swift
//  Swift_Project
//
//  Created by lvzheng on 2020/4/23.
//  Copyright © 2020 lvzheng. All rights reserved.
//

import UIKit
import RealmSwift

class DataBaseManager: NSObject {    
    static let share = DataBaseManager()
    override init() {
        super.init()
    }
    
    /// 配置数据库
    func configRealm() {
        /// 如果要存储的数据模型属性发生变化,需要配置当前版本号比之前大
        let dbVersion : UInt64 = 3
        let docPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0] as String
        let phone = LoginManager.share.currentUser!.cellphone!
        let dbPath = docPath.appending("/\(String(describing: phone)).realm")
        debugPrint(dbPath)
        let config = Realm.Configuration(fileURL: URL.init(string: dbPath), inMemoryIdentifier: nil, syncConfiguration: nil, encryptionKey: nil, readOnly: false, schemaVersion: dbVersion, migrationBlock: { (migration, oldSchemaVersion) in
            
        }, deleteRealmIfMigrationNeeded: false, shouldCompactOnLaunch: nil, objectTypes: nil)
        Realm.Configuration.defaultConfiguration = config
        Realm.asyncOpen { (realm, error) in
            if let _ = realm {
                print("Realm 服务器配置成功!")
            }else if let error = error {
                print("Realm 数据库配置失败：\(error.localizedDescription)")
            }
        }
    }
}
