//
//  UserInfoViewController.swift
//  Swift_Project
//
//  Created by lz on 2021/5/8.
//  Copyright © 2021 lvzheng. All rights reserved.
//

import UIKit
import URLNavigator

class UserInfoViewController: UIViewController {
    private let navigator: NavigatorType
    let titleName: String

    init(navigator: NavigatorType, titleName: String, userInfo: UserInfo?) {
      self.navigator = navigator
      self.titleName = titleName
      super.init(nibName: nil, bundle: nil)
      self.title = "\(titleName)'s Repositories"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
