//
//  LoginViewController.swift
//  Swift_Project
//
//  Created by lvzheng on 2020/4/7.
//  Copyright © 2020 lvzheng. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    let titleLabel = UILabel()
    var userNameTF: LoginTextFieldView!
    var passwordTF: LoginTextFieldView!
    let loginBtn = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
    }
    
    func setupUI() {
        self.view.backgroundColor = UIColor.white
        
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 30)
        titleLabel.text = "密码登录"
        self.view.addSubview(titleLabel)
        
        userNameTF = LoginTextFieldView(frame: .zero, placeholder: "请输入用户名", isSecureTextEntry: false, keyboardType: .namePhonePad)
        userNameTF.textField.text = "15800000003"
        self.view.addSubview(userNameTF!)
        
        passwordTF = LoginTextFieldView(frame: .zero, placeholder: "请输入密码", isSecureTextEntry: true, keyboardType: .default)
        passwordTF.textField.text = "000003"
        self.view.addSubview(passwordTF!)
        
        loginBtn.setTitle("登录", for: UIControl.State.normal)
        loginBtn.backgroundColor = UIColor.orange;
        loginBtn.setTitleColor(UIColor.white, for: .normal)
        loginBtn.layer.cornerRadius = 20
        loginBtn.layer.masksToBounds = true
        loginBtn.addTarget(self, action: #selector(loginAction(button:)), for: .touchUpInside)
        self.view.addSubview(loginBtn)
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(120)
            make.right.equalToSuperview().offset(-100)
            make.height.equalTo(50)
        }
        
        userNameTF!.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(100)
            make.left.equalToSuperview().offset(80)
            make.right.equalToSuperview().offset(-80)
            make.height.equalTo(30)
        }
        
        passwordTF!.snp.makeConstraints { (make) in
            make.top.equalTo(userNameTF!.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(80)
            make.right.equalToSuperview().offset(-80)
            make.height.equalTo(30)
        }
        
        loginBtn.snp.makeConstraints { (make) in
            make.top.equalTo(passwordTF!.snp.bottom).offset(40)
            make.left.equalToSuperview().offset(80)
            make.right.equalToSuperview().offset(-80)
            make.height.equalTo(40)
        }
    }
    
    @objc func loginAction(button: UIButton) {
        let dic = ["memberCellphone": userNameTF.content(),
                   "loginPwd": passwordTF.content()]
        RequestManager.share.requestByTargetType(targetType: YSendArticelAPI.postArticel(params: dic),
                                                 path: .login,
                                                 model: YNormalModel.self,
                                                 success:
            { [weak self] (response, json) in
            LoginManager.share.currentUser = userModel.deserialize(from: response.data)
            self?.jumpMainPage()
        }) { (error) in
            SVProgressHUD.showError(withStatus: error.message)
            self.jumpMainPage()
        }
    }
    
    func jumpMainPage() {
        let keyWindow = UIApplication.shared.keyWindow
        keyWindow?.rootViewController?.dismiss(animated: true, completion: nil)
        keyWindow?.rootViewController = CTabBarViewController()
        keyWindow?.makeKeyAndVisible()
//        DataBaseManager.share.configRealm()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        userNameTF!.cancelResponder()
        passwordTF!.cancelResponder()
    }
}
