//
//  ProtocolViewController.swift
//  Swift_Project
//
//  Created by 吕征 on 2020/10/9.
//  Copyright © 2020 lvzheng. All rights reserved.
//

import UIKit

class ProtocolViewController: UIViewController, SomeProtocol {
    var delegate: SomeProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let obj = ProtocolObject()
        self.delegate = obj
        print("protocolObject index = \(self.delegate?[1000] ?? -10)")
        self.delegate?.printSelfName()
    }
    lazy var changeColorView: UIView = {
        let view = UIView.init(frame: CGRect(x: 100, y: 100, width: 120, height: 80))
        view.backgroundColor = UIColor.yellow
        self.view.addSubview(view)
        return view
    }()
    
    func changeColor(color: UIColor) {
        self.changeColorView.backgroundColor = UIColor.red
    }
}


