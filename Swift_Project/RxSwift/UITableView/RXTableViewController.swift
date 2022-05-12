//
//  RXTableViewController.swift
//  Swift_Project
//
//  Created by lz on 2021/3/25.
//  Copyright © 2021 lvzheng. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class RXTableViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var musicViewModel = MusicListViewModel()
    lazy var bag = DisposeBag()
    
    let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<MusicSectionModel, MusicModel>>  { (_, tableView, indexPath, model) -> UITableViewCell in
        let cell = tableView.dequeueReusableCell(withIdentifier: "MusicCellIdentifier") as! MusicTableViewCell
        cell.singerName.text = model.singer
        cell.songName.text = model.name
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        tableView.register(UINib.init(nibName: "MusicTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "MusicCellIdentifier")
        tableView.rx.setDelegate(self)
            .disposed(by: bag)
        
//        = musicViewModel.initDataArray()
        // 绑定数据
        musicViewModel.initDataArray()
            .bind(to: tableView.rx.items(dataSource: self.dataSource))
            .disposed(by: bag)
        
        // 选中cell
        tableView.rx.itemSelected
            .map { (indexPath) -> (IndexPath, MusicModel) in
                return (indexPath, self.dataSource[indexPath])
            }.subscribe { (indexPath, model) in
                
            }.disposed(by: bag)
        
        // 上下拉刷新
        tableView.mj_header = MJRefreshNormalHeader()
        tableView.mj_header?.setRefreshingTarget(self, refreshingAction: #selector(headerRefreshAction))
        tableView.mj_footer = MJRefreshAutoNormalFooter()
        tableView.mj_footer?.setRefreshingTarget(self, refreshingAction: #selector(footerRefreshAction))
    }

}

extension RXTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        let sModel = self.dataSource[section]
        headerView.backgroundColor = sModel.model.bgColor
        let titleLabel = UILabel()
        titleLabel.text = sModel.model.area
        titleLabel.textColor = UIColor.white
        titleLabel.sizeToFit()
        titleLabel.center = CGPoint(x: self.view.frame.width/2, y: 20)
        headerView.addSubview(titleLabel)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}

extension RXTableViewController {
    @objc func headerRefreshAction() {
        tableView.dataSource = nil
        musicViewModel.initDataArray()
            .bind(to: tableView.rx.items(dataSource: self.dataSource))
            .disposed(by: bag)
        tableView.mj_header?.endRefreshing()
    }
    
    @objc func footerRefreshAction() {
        tableView.dataSource = nil
        musicViewModel.updateDataArray()
            .bind(to: tableView.rx.items(dataSource: self.dataSource))
            .disposed(by: bag)
        tableView.mj_header?.endRefreshing()
    }
}
