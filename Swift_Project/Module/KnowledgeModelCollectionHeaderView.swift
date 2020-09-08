//
//  KnowledgeModelCollectionHeaderView.swift
//  Swift_Project
//
//  Created by lvzheng on 2020/9/3.
//  Copyright © 2020 lvzheng. All rights reserved.
//

import UIKit

class KnowledgeModelCollectionHeaderView: UICollectionReusableView {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        self.backgroundColor = UIColor.yellow
        self.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(15)
            make.size.equalTo(CGSize(width: 200, height: 25))
        }
    }
    
    func setTitle(title: String) {
        self.titleLabel.text = title
    }
    
    lazy var titleLabel:UILabel = {
        let label = UILabel.init()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
}
