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
    let pictures: [String] = ["https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1587550108944&di=cbec18ad90ced2d291b1c756888ca119&imgtype=0&src=http%3A%2F%2Fimg1.gtimg.com%2Frushidao%2Fpics%2Fhv1%2F20%2F108%2F1744%2F113431160.jpg", "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1587550108944&di=cbec18ad90ced2d291b1c756888ca119&imgtype=0&src=http%3A%2F%2Fimg1.gtimg.com%2Frushidao%2Fpics%2Fhv1%2F20%2F108%2F1744%2F113431160.jpg", "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1587550108944&di=cbec18ad90ced2d291b1c756888ca119&imgtype=0&src=http%3A%2F%2Fimg1.gtimg.com%2Frushidao%2Fpics%2Fhv1%2F20%2F108%2F1744%2F113431160.jpg"]
    let titles: [String] = ["aaa", "bbb", "ccc", "ddd", "fff"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "首页"
        cyclePictureView = CyclePicturePlayView.init(frame: CGRect(x: 0, y: 0, width: ScreenSize.width, height: ScreenSize.width * 0.6), pictures: pictures)
        self.view.addSubview(cyclePictureView!)
        self.creatTableView()
        self.requestData()
    }
    
    func requestData() {
        RequestManager.share.requestByTargetType(targetType: YSendArticelAPI.postNoHud(params: [:]),
                                                 path: YSendArticelPath.home_banner,
                                                 model: YNormalModel.self,
                                                 success: { (response, json) in
             debugPrint(json)
        }) { _ in ()}
    }
    
    func creatTableView() {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 44
        tableView.separatorStyle = .none
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: tableViewCellIdentifier)
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(cyclePictureView!.snp_bottomMargin).offset(0)
            make.left.right.bottom.equalToSuperview().offset(0)
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellIdentifier)!
        cell.selectionStyle = .none
        cell.textLabel?.text = titles[indexPath.row]
        return cell
    }
}
