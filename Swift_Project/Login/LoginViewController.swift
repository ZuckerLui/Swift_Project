//
//  LoginViewController.swift
//  Swift_Project
//
//  Created by lvzheng on 2020/4/7.
//  Copyright © 2020 lvzheng. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import URLNavigator

class LoginViewController: UIViewController {
    let titleLabel = UILabel()
    var userNameTF: LoginTextFieldView!
    var userNameValidLabel = UILabel()
    var passwordTF: LoginTextFieldView!
    var passwordValidLabel = UILabel()
    let loginBtn = UIButton()
    let signUpBtn = UIButton()
    private let navigator: NavigatorType

    lazy var bag = DisposeBag()
    
    init(navigator: NavigatorType) {
        self.navigator = navigator

        super.init(nibName: nil, bundle: nil)

//        self.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        
        // bind
        let viewModel = LoginValidViewModel(userNameTF.textField.rx.text.orEmpty.asObservable(), passwordTF.textField.rx.text.orEmpty.asObservable())
        
        viewModel.userNameValid.bind(to: userNameValidLabel.rx.isHidden)
            .disposed(by: bag)
        
        viewModel.passwordValid.bind(to: passwordValidLabel.rx.isHidden)
            .disposed(by: bag)
        
        // 监听登录按钮可点击状态
        viewModel.everythingValid.bind(to: loginBtn.rx.isEnabled)
            .disposed(by: bag)
        
        // 监听登录按钮颜色
        viewModel.everythingValid.subscribe { (valid) in
            self.loginBtn.backgroundColor = valid ? .orange : .gray
        }.disposed(by: bag)
    
        // 登录
        loginBtn.rx.tap.subscribe { [weak self] () in
            self?.jumpMainPage()
            
        } onError: { (error) in
            
        } onCompleted: {
            
        } onDisposed: {
            
        } .disposed(by: bag)
        
        // 注册
        signUpBtn.rx.tap.subscribe(onNext: { [weak self] () in
            self?.present(SignUpViewController(), animated: true, completion: nil)
        }, onError: nil, onCompleted: nil, onDisposed: nil)
        .disposed(by: bag)
    }

    
    @objc func loginAction(button: UIButton) {
        
        
//        self.jumpMainPage()
    }
    
    func jumpMainPage() {
        UserManager.shared.login(account: userNameTF.textField.text ?? "", password: passwordTF.textField.text ?? "", verifyCode: "") { (error) in
            
        }
        let keyWindow = UIApplication.shared.keyWindow
        keyWindow?.rootViewController?.dismiss(animated: true, completion: nil)
        keyWindow?.rootViewController = CTabBarViewController(navigator: navigator)
        keyWindow?.makeKeyAndVisible()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        userNameTF!.cancelResponder()
        passwordTF!.cancelResponder()
    }
}

//MARK:
extension LoginViewController {
    
}

//MARK:UI
extension LoginViewController {
    func setupUI() {
        self.view.backgroundColor = UIColor.white
        
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 30)
        titleLabel.text = "密码登录"
        self.view.addSubview(titleLabel)
        
        // 用户名
        userNameTF = LoginTextFieldView(frame: .zero, placeholder: "请输入用户名", isSecureTextEntry: false, keyboardType: .namePhonePad)
        userNameTF.textField.text = "jimitest"
        self.view.addSubview(userNameTF!)
        
        userNameValidLabel.font = UIFont.systemFont(ofSize: 12)
        userNameValidLabel.textColor = .red
        userNameValidLabel.isHidden = true
        userNameValidLabel.text = "用户名需要至少6位字符"
        self.view.addSubview(userNameValidLabel)
        
        // 密码
        passwordTF = LoginTextFieldView(frame: .zero, placeholder: "请输入密码", isSecureTextEntry: true, keyboardType: .default)
        passwordTF.textField.text = "jimi123"
        self.view.addSubview(passwordTF!)
        
        passwordValidLabel.font = UIFont.systemFont(ofSize: 12)
        passwordValidLabel.textColor = .red
        passwordValidLabel.isHidden = true
        passwordValidLabel.text = "密码需要至少6位字符"
        self.view.addSubview(passwordValidLabel)
        
        // 登录按钮
        loginBtn.setTitle("登录", for: UIControl.State.normal)
//        loginBtn.acceptEventInterval = 2
        loginBtn.backgroundColor = UIColor.orange;
        loginBtn.setTitleColor(UIColor.white, for: .normal)
        loginBtn.layer.cornerRadius = 20
        loginBtn.layer.masksToBounds = true
//        loginBtn.addTarget(self, action: #selector(loginAction(button:)), for: .touchUpInside)
        self.view.addSubview(loginBtn)
        
        signUpBtn.setTitle("注册", for: .normal)
        signUpBtn.setTitleColor(.blue, for: .normal)
        self.view.addSubview(signUpBtn)
        
        
        titleLabel.snp.makeConstraints { (make) in
            if #available(iOS 11.0, *) {
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(120)
            } else {
                make.top.equalToSuperview().offset(120)
            }
            make.left.equalToSuperview().offset(100)
            make.right.equalToSuperview().offset(-100)
            make.height.equalTo(50)
        }
        
        userNameTF!.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(100)
            make.left.equalToSuperview().offset(80)
            make.right.equalToSuperview().offset(-80)
            make.height.equalTo(30)
        }
        
        userNameValidLabel.snp.makeConstraints { (make) in
            make.top.equalTo(userNameTF.snp.bottom).offset(5)
            make.left.right.equalTo(userNameTF)
            make.height.equalTo(12)
        }
        
        passwordTF!.snp.makeConstraints { (make) in
            make.top.equalTo(userNameTF!.snp.bottom).offset(35)
            make.left.equalToSuperview().offset(80)
            make.right.equalToSuperview().offset(-80)
            make.height.equalTo(30)
        }
        
        passwordValidLabel.snp.makeConstraints { (make) in
            make.top.equalTo(passwordTF.snp.bottom).offset(5)
            make.left.right.equalTo(userNameTF)
            make.height.equalTo(12)
        }
        
        loginBtn.snp.makeConstraints { (make) in
            make.top.equalTo(passwordTF!.snp.bottom).offset(45)
            make.left.equalToSuperview().offset(80)
            make.right.equalToSuperview().offset(-80)
            make.height.equalTo(40)
        }
        
        signUpBtn.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-30)
        }
    }
}
