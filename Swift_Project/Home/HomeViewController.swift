//
//  HomeViewController.swift
//  Swift_Project
//
//  Created by lvzheng on 2020/4/12.
//  Copyright © 2020 lvzheng. All rights reserved.
//

import UIKit

let tableViewCellIdentifier = "tableViewCellIdentifier"

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var cyclePictureView: CyclePicturePlayView?
    var pageView: PageView?
    var canScroll: Bool = true
    
    let pictures: [String] = ["https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1587550108944&di=cbec18ad90ced2d291b1c756888ca119&imgtype=0&src=http%3A%2F%2Fimg1.gtimg.com%2Frushidao%2Fpics%2Fhv1%2F20%2F108%2F1744%2F113431160.jpg", "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1587550108944&di=cbec18ad90ced2d291b1c756888ca119&imgtype=0&src=http%3A%2F%2Fimg1.gtimg.com%2Frushidao%2Fpics%2Fhv1%2F20%2F108%2F1744%2F113431160.jpg", "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1587550108944&di=cbec18ad90ced2d291b1c756888ca119&imgtype=0&src=http%3A%2F%2Fimg1.gtimg.com%2Frushidao%2Fpics%2Fhv1%2F20%2F108%2F1744%2F113431160.jpg"]
    let titles: [String] = ["aaa", "bbb", "ccc", "ddd", "fff"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.requestData()
        
        self.navigationItem.title = "首页"
        self.view.addSubview(self.tableView)
        NotificationCenter.default.addObserver(self, selector: #selector(changeScrollStatus), name: NSNotification.Name(rawValue: "leaveTop"), object: nil)
    }
    
    @objc func changeScrollStatus() -> Void {
        self.canScroll = true
        self.pageView?.superCanScroll = false
    }
    
    func requestData() {
        RequestManager.share.requestByTargetType(targetType: YSendArticelAPI.postNoHud(params: [:]),
                                                 path: YSendArticelPath.home_banner,
                                                 model: YNormalModel.self,
                                                 success: { (response, json) in
             debugPrint(json)
        }) { _ in ()}
    }
    
    lazy var tableView: UITableView = {
        let tableView = HomeTableview(frame: CGRect(x: 0, y: ScreenSize.topAreaHeight, width: ScreenSize.width, height: ScreenSize.haveBottomHeight), style: .plain)
        cyclePictureView = CyclePicturePlayView.init(frame: CGRect(x: 0, y: 0, width: ScreenSize.width, height: ScreenSize.width * 0.6), pictures: pictures)
        tableView.tableHeaderView = cyclePictureView
        tableView.showsVerticalScrollIndicator = false
        pageView = PageView(frame: CGRect(x: 0, y: 0, width: ScreenSize.width, height: tableView.height - 45), count: 5)
        tableView.tableFooterView = pageView
        pageView?.scrollBlock = {[weak self] (newY) in
           
        }
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
}

extension HomeViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "")!
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionHeaderView = TitleView(frame: CGRect(x: 0, y: 0, width: ScreenSize.width, height: 45), titles: ["精选", "热点", "同城", "哈哈", "通知"])
        return sectionHeaderView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 第0组的最上面
        let sectionTop = self.tableView.rect(forSection: 0).origin.y
        if scrollView.contentOffset.y >= sectionTop { // 偏移量到达第0组的最上面时
            // 让父tableview的偏移量永远等于sectionTop
            scrollView.contentOffset = CGPoint(x: 0, y: sectionTop)
            if self.canScroll {
                self.canScroll = false;
                self.pageView?.superCanScroll = true;
            }
        } else {
            if !self.canScroll {//子cell没到顶
                scrollView.contentOffset = CGPoint(x: 0, y: sectionTop);
            }
        }
    }
}
