//
//  FileTool.swift
//  Swift_Project
//
//  Created by lvzheng on 2020/9/3.
//  Copyright © 2020 lvzheng. All rights reserved.
//

import UIKit

class FileTool: NSObject {
    public class func readJsonFromFile(_ fileName: String) -> Any? {
        let path = Bundle.main.path(forResource: fileName, ofType: "json")
        let url = URL(fileURLWithPath: path!)
        // 带throws的方法需要抛异常
        do {
            /*
             * try    try？   try!
             * try 发生异常会跳到catch代码中
             * try? 返回一个可选类型
             * try! 发生异常程序会直接crash
             */
            let data = try Data(contentsOf: url)
            let result:Any = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
            return result
        } catch let error as Error? {
            print("读取本地数据出现错误!error=\(error.debugDescription)")
        }
        return nil
    }
}
