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
    
    convenience init(frame: CGRect, placeholder: String, isSecureTextEntry: Bool, keyboardType: UIKeyboardType) {
        self.init(frame: frame)
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func cancelResponder() {
        textField.resignFirstResponder()
    }
}
