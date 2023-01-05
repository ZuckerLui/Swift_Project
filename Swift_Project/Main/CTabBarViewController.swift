//
//  TabBarViewController.swift
//  Swift_Project
//
//  Created by lvzheng on 2020/4/12.
//  Copyright © 2020 lvzheng. All rights reserved.
//

import UIKit
import URLNavigator

class CTabBarViewController: UITabBarController {

        let imageArray = ["icon_tabbar_home_nor", "icon_tabbar_me_nor", "icon_tabbar_study_nor", ""];
        let selectImageArray = ["icon_tabbar_home_sel", "icon_tabbar_me_sel", "icon_tabbar_study_sel", ""];
        private let navigator: NavigatorType
    
    
        init(navigator: NavigatorType) {
            self.navigator = navigator
            super.init(nibName: nil, bundle: nil)
        }
    
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
        override func viewDidLoad() {
            super.viewDidLoad()
            // 修改标签栏选中时文字颜色、字体
            UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.hexadecimalColor(hexadecimal: "#F5B22A"), NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 12.0)], for: .selected)
            // 修改标签栏未选中时文字颜色、字体
            UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.hexadecimalColor(hexadecimal: "#9E9E9E"), NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 12.0)], for: .normal)
            self.setup()
        }

        func setup() {
            self.tabBar.tintColor = UIColor.red
            
            self.addViewController(childViewController: HomeViewController(navigator: navigator), title: "首页", image: UIImage(named: imageArray[0])!, selectImage: UIImage(named: selectImageArray[0])!, index: 0)
            self.addViewController(childViewController: MeViewController(), title: "我的", image: UIImage(named: imageArray[1])!, selectImage: UIImage(named: selectImageArray[1])!, index: 1)
            self.addViewController(childViewController: KnowledgeModelViewController(), title: "Module", image: UIImage(named: imageArray[2])!, selectImage: UIImage(named: selectImageArray[2])!, index: 2)
        }

        func addViewController(childViewController: UIViewController, title: String, image: UIImage, selectImage: UIImage, index: Int) {
            let nav = CNavigationViewController(rootViewController: childViewController)
            nav.tabBarItem = UITabBarItem(title: title, image: image, selectedImage: selectImage)
            childViewController.tabBarItem.tag = index
            self.addChild(nav)
        }
}
