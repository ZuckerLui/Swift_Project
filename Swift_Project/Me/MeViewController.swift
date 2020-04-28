//
//  MeViewController.swift
//  Swift_Project
//
//  Created by lvzheng on 2020/4/12.
//  Copyright © 2020 lvzheng. All rights reserved.
//

import UIKit

class MeViewController: UIViewController, changeViewProtocol {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "我的"
        self.view.backgroundColor = UIColor.white
        
        let label = UILabel(frame: CGRect(x: 100, y: 200, width: 100, height: 30))
        self.view.addSubview(label)
        
        let pView = ProtocolView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        pView.backgroundColor = UIColor.orange
        pView.delegate = self
        self.view.addSubview(pView)
        pView.changeBlock = { (text, color) in
            label.text = text
            label.textColor = color
        }
//        pView.changeColorAndText { (text, color) in
//            label.text = text
//            label.textColor = color
//        }
    }
    
    func displayContent(view: ProtocolView) {
        view.label.text = "display"
    }
    
    func makeIncrementor(forIncrement amount: Int) -> () -> Int {
        var runningTotal = 0
        func incrementor() -> Int {
            print("runningTotal = \(runningTotal), amount = \(amount)")
            runningTotal += amount
            return runningTotal
        }
        return incrementor
    }

    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let incrementByTen = makeIncrementor(forIncrement: 10)
        print(incrementByTen())
        print(incrementByTen())
    }
}

