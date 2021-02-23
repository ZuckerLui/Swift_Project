//
//  RXBaseViewController.swift
//  Swift_Project
//
//  Created by 吕征 on 2021/2/13.
//  Copyright © 2021 lvzheng. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class RXBaseViewController: UIViewController {

    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var label: UILabel!
    
    lazy var bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 监听按钮点击
        btn1.rx.tap.subscribe { (event: Event<Void>) in
            print("按钮发生了点击")
        }.disposed(by: bag)
        
        // 监听textField改变
        textField.rx.text.subscribe { (text: String?) in
            print("textfield: \(text ?? "")")
        }.disposed(by: bag)

        // textField的text绑定给label
        textField.rx.text
            .bind(to: label.rx.text)
            .disposed(by: bag)
        
        // rx中的添加观察者
        textField.rx.observe(String.self, "text").subscribe { (text: String?) in
            
        }.disposed(by: bag)

//        textField.rx.observe(<#T##keyPath: KeyPath<UITextField, Element>##KeyPath<UITextField, Element>#>, options: <#T##NSKeyValueObservingOptions#>)


    }
}
