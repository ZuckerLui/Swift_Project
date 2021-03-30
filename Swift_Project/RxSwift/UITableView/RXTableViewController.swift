//
//  RXTableViewController.swift
//  Swift_Project
//
//  Created by jimi01 on 2021/3/25.
//  Copyright © 2021 lvzheng. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class RXTableViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let musicViewModel = MusicListViewModel()
    lazy var bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        tableView.register(UINib.init(nibName: "MusicTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "MusicCellIdentifier")
        
        // datasource绑定到tableview
        musicViewModel.dataSource.bind(to: tableView.rx.items(cellIdentifier: "MusicCellIdentifier", cellType: MusicTableViewCell.self)) {row, model, cell in
            cell.singerName.text = model.singer
            cell.songName.text = model.name
        }.disposed(by: bag)
        
        // 点击cell -- modelSelected,
        tableView.rx.modelSelected(MusicModel.self).subscribe { (item) in
            print("歌曲：\(item.element?.name) ，歌手：\(item.element?.singer)")
        }.disposed(by: bag)
        
        // 点击cell -- itemSelected
        tableView.rx.itemSelected.subscribe { (indexPath) in
            
        }.disposed(by: bag)
    }

    @IBAction func changeDataSource(_ sender: Any) {
        musicViewModel.updateViewModel()
        tableView.reloadData()
    }
}
