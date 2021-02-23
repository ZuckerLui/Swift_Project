//
//  LoginTextFieldView.swift
//  Swift_Project
//
//  Created by lvzheng on 2020/4/8.
//  Copyright © 2020 lvzheng. All rights reserved.
//

import UIKit

class LoginTextFieldView: UIView , UITextFieldDelegate{
    var textField = UITextField()
    let lineView = UIView()
    private (set) var name:Int = 0 // 对外只读，对内可读写属性，set表示只有setter方法是私有的，getter不是
    private var age:Int = 1
    fileprivate var address:String = "address"
    
    init(frame: CGRect, placeholder: String, isSecureTextEntry: Bool, keyboardType: UIKeyboardType) {
        super.init(frame: frame)
        name = 7
        textField.placeholder = placeholder
        textField.keyboardType = keyboardType
        textField.isSecureTextEntry = isSecureTextEntry
        textField.delegate = self
        self.addSubview(textField)
        textField.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview().offset(0)
            make.bottom.equalToSuperview().offset(-1)
        }
        
        lineView.backgroundColor = UIColor.gray
        self.addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview().offset(0)
            make.height.equalTo(1)
        }
    }
    
    func content() -> String {
        return textField.text ?? ""
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        lineView.backgroundColor = UIColor.orange
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        lineView.backgroundColor = UIColor.gray
        return true
    }
    
    func cancelResponder() {
        textField.resignFirstResponder()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class subTf: LoginTextFieldView {
    func test() {
        print("\(address)") // fileprivate只要在一个文件下，都可以访问
//        self.age   即使是继承，private属性也不能访问
    }
}


extension LoginTextFieldView {
	
}
