//
//  KnowledgeModelViewController.swift
//  Swift_Project
//
//  Created by lvzheng on 2020/6/4.
//  Copyright © 2020 lvzheng. All rights reserved.
//

import UIKit
import HandyJSON

let KnowledgeModelCellIdentifier = "KnowledgeModelCellIdentifier"
let KnowledgeModelCollectionHeaderViewIdentifier = "KnowledgeModelCollectionHeaderViewIdentifier"

class KnowledgeModelViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
 
    var collectionView: UICollectionView!
    var dataSource = Array<knowledgeSectionModel>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let layout = CustomCollectionViewFlowLayout.init()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 10;
        layout.sectionInset = UIEdgeInsets.init(top: 5, left: 5, bottom: 5, right: 5)
        
        collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.register(KnowledgeModelCell.self, forCellWithReuseIdentifier: KnowledgeModelCellIdentifier)
        collectionView.register(KnowledgeModelCollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: KnowledgeModelCollectionHeaderViewIdentifier)
        self.view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        }
        self.initData()
    }
    
    func initData() {
        let data = FileTool.readJsonFromFile("knowledgeModel") as? Array<Any>
        if let result = JSONDeserializer<knowledgeSectionModel>.deserializeModelArrayFrom(array: data) {
            self.dataSource = result as! [knowledgeSectionModel]
            self.collectionView.reloadData()
        }
        
    }
}

extension KnowledgeModelViewController {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionModel: knowledgeSectionModel = self.dataSource[section]
        return sectionModel.subModules?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KnowledgeModelCellIdentifier, for: indexPath) as! KnowledgeModelCell
        let sectionModel: knowledgeSectionModel = self.dataSource[indexPath.section]
        let model: KnowledgeModel = (sectionModel.subModules?[indexPath.row])!
        cell.setValueForCell(model)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sectionModel: knowledgeSectionModel = self.dataSource[indexPath.section]
        let model: KnowledgeModel = (sectionModel.subModules?[indexPath.row])!
        if let name = model.controllerName {
            let vc = (NSClassFromString(name) as! UIViewController.Type).init()
            vc.hidesBottomBarWhenPushed = true;
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let sectionModel: knowledgeSectionModel = self.dataSource[indexPath.section]
            let reusableView:KnowledgeModelCollectionHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: KnowledgeModelCollectionHeaderViewIdentifier, for: indexPath) as! KnowledgeModelCollectionHeaderView
            reusableView.setTitle(title: sectionModel.sectionTitle)
            return reusableView
        } else{
            return UICollectionReusableView()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sectionModel: knowledgeSectionModel = self.dataSource[indexPath.section]
        let model: KnowledgeModel = (sectionModel.subModules?[indexPath.row])!
        let width = model.moduleName?.getSize(CGSize(width: Double(MAXFLOAT), height: 20.0), attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]).width
        return CGSize(width: (width ?? 0.0) + 16, height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: ScreenSize.width, height: 55)
    }
}
