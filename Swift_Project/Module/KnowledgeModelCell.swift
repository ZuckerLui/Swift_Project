//
//  KnowledgeModelCell.swift
//  Swift_Project
//
//  Created by lvzheng on 2020/6/4.
//  Copyright © 2020 lvzheng. All rights reserved.
//

import UIKit

class KnowledgeModelCell: UICollectionViewCell {
    
    var model: KnowledgeModel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        self.backgroundColor = UIColor.lightGray
        self.addSubview(self.nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(8)
            make.right.bottom.equalToSuperview().offset(-8)
        }
    }
    
    func setValueForCell(_ model: KnowledgeModel) {
        self.nameLabel.text = model.moduleName
    }
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
}
