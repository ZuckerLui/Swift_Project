//
//  CustomerDBManager.swift
//  Swift_Project
//
//  Created by lvzheng on 2020/4/24.
//  Copyright © 2020 lvzheng. All rights reserved.
//

import UIKit
import RealmSwift

class CustomerRealmTool: NSObject {
    private class func getDB() -> Realm {
        let docPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0] as String
        let phone = LoginManager.share.currentUser!.cellphone!
        let dbPath = docPath.appending("/\(phone).realm")
        /// 传入路径会自动创建数据库
        let defaultRealm = try! Realm(fileURL: URL.init(string: dbPath)!)
        return defaultRealm
    }
}

/// 增
extension CustomerRealmTool {
   
    public class func insertCustomer(by customer : CustomerModel) -> Void {
        let defaultRealm = self.getDB()
        try! defaultRealm.write {
            defaultRealm.add(customer)
        }
        print(defaultRealm.configuration.fileURL ?? "")
    }
    
    public class func alterCustomerInfo(by customer: CustomerModel) {
        let defaultRealm = self.getDB()
        try! defaultRealm.write {
            defaultRealm.add(customer, update: .modified)
        }
    }
    
    public class func insertCustomers(by customers: [CustomerModel]) {
        let defaultRealm = self.getDB()
        try! defaultRealm.write {
            defaultRealm.add(customers)
        }
    }
    
    public class func query(by filter: String) -> Results<CustomerModel> {
        let defaultRealm = self.getDB()
        let customers = defaultRealm.objects(CustomerModel.self).filter(filter)
        return customers
    }
}
