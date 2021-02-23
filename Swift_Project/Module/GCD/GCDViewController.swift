//
//  GCDViewController.swift
//  Swift_Project
//
//  Created by 吕征 on 2020/10/20.
//  Copyright © 2020 lvzheng. All rights reserved.
//

import UIKit

class GCDViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        // Do any additional setup after loading the view.
    }

    @objc func creatQueueAsyncAction(_ btn: UIButton) {
        let queue = DispatchQueue(label: "com.zucker.thread")
        queue.async {
            print("耗时操作异步执行：\(Thread.current)")
            Thread.sleep(forTimeInterval: 2)
        
            DispatchQueue.main.async {
                print("回到主线程刷新UI：\(Thread.current)")
            }
        }
    }
    
    @objc func globalQueueSyncAction(_ btn: UIButton) {
        for i in 1...5 {
            DispatchQueue.global().sync {
                print("并发同步正在执行\(i)任务，threed\(Thread.current)")
            }
        }
    }
    
    @objc func groupAction(_ btn: UIButton) {
        let group = DispatchGroup()
        let serialQueue = DispatchQueue(label: "com.serial.thread") // 串行队列
        let concurrentQueue = DispatchQueue(label: "com.concurrent.thread", qos: .default, attributes: .concurrent, autoreleaseFrequency: .workItem, target: nil) // 并行队列
        
        // notify依赖任务
        serialQueue.async(group: group, qos: .default, flags: []) {
            print("串行任务一 \(Thread.current)")
            sleep(2)
        }
        
        serialQueue.async(group: group, qos: .default, flags: []) {
            print("串行任务二 \(Thread.current)")
        }
        
        concurrentQueue.async(group: group, qos: .default, flags: []) {
            print("并发任务一 \(Thread.current)")
            sleep(2)
        }
        concurrentQueue.async(group: group, qos: .default, flags: []) {
            print("并发任务二 \(Thread.current)")
        }
        
        
        
        let workItem = DispatchWorkItem {
            print("任务全部处理完毕 \(Thread.current)")
        }
        group.notify(queue: DispatchQueue.main, work: workItem)
    }
    
    @objc func semaphoreAction(_ btn: UIButton) {
        // 信号量，控制同时执行任务的数量
        let semaphore = DispatchSemaphore(value: 2)
        DispatchQueue.global().async {
            semaphore.wait()
            print("执行任务1 \(Thread.current)")
            sleep(2)
            print("完成任务1")
            semaphore.signal()
        }
        
        DispatchQueue.global().async {
            semaphore.wait()
            print("执行任务2 \(Thread.current)")
            sleep(2)
            print("完成任务2")
            semaphore.signal()
        }
        
        DispatchQueue.global().async {
            semaphore.wait()
            print("执行任务3 \(Thread.current)")
            sleep(2)
            print("完成任务3")
            semaphore.signal()
        }
    }
}

extension GCDViewController {
    func setupUI() {
        self.view.backgroundColor = .white
        self.view.addSubview(self.creatbtn(CGRect(x: 50, y: 100, width: 100, height: 40), "手动创建队列", #selector(creatQueueAsyncAction(_:))))
        self.view.addSubview(self.creatbtn(CGRect(x: 200, y: 100, width: 100, height: 40), "全局并发同步队列", #selector(globalQueueSyncAction(_:))))
        self.view.addSubview(self.creatbtn(CGRect(x: 50, y: 200, width: 100, height: 40), "任务组", #selector(groupAction(_:))))
        self.view.addSubview(self.creatbtn(CGRect(x: 200, y: 200, width: 100, height: 40), "信号量", #selector(semaphoreAction(_:))))
    }
    
    func creatbtn(_ frame: CGRect, _ title: String, _ action: Selector) -> UIButton {
        let btn = UIButton.init(type: .custom)
        btn.frame = frame
        btn.setTitle(title, for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.adjustsFontSizeToFitWidth = true
        btn.addTarget(self, action: action, for: .touchUpInside)
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.black.cgColor
        return btn
    }
}
