//
//  NavigationViewController.swift
//  Swift_Project
//
//  Created by lvzheng on 2020/4/12.
//  Copyright © 2020 lvzheng. All rights reserved.
//

import UIKit

class CNavigationViewController: UINavigationController {

   override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if children.count > 0 {
            viewController.hidesBottomBarWhenPushed = true;
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "nav_back_icon"), style: .done, target: self, action: #selector(backAction));
        }
        super.pushViewController(viewController, animated: true)
    }
    
    @objc func backAction() {
        popViewController(animated: true);
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let bar = UINavigationBar.appearance()
        bar.tintColor = UIColor.black
        bar.titleTextAttributes = [.font: UIFont.systemFont(ofSize: 17), .foregroundColor: UIColor.black];
    }
}
