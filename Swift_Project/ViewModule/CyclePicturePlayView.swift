//
//  PicturePlayView.swift
//  Swift_Project
//
//  Created by lvzheng on 2020/4/14.
//  Copyright © 2020 lvzheng. All rights reserved.
//

import UIKit

let CyclePictureCellIdentifier = "CyclePictureCellIdentifier"

class CyclePicturePlayView: UIView{
    
    /// 图片数据源
    open var pictures: [String] = Array()
    
    open var placeholderImage: UIImage?
    
    public convenience init(frame: CGRect, pictures: [String]?) {
        
        self.init(frame: frame)
        
        if let pictures = pictures {

            self.pictures = pictures
        }
//
//        self.collectionView.scrollToItem(at: IndexPath(item: 1, section: 0), at: self.scrollPosition, animated: false)
//
//        self.bringSubviewToFront(self.pageControl)
//
//        self.startTimer()
        self.addSubview(self.collectionView)
    }
    
    func startTimer() {
        
    }
    
    lazy var collectionView: UICollectionView = {
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = self.frame.size
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let collectionView: UICollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height), collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(CyclePictureViewCell.self, forCellWithReuseIdentifier: CyclePictureCellIdentifier)
        collectionView.backgroundColor = UIColor.clear
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.delegate = self
        
        return collectionView
    }()
    
    /// PageControl
    open lazy var pageControl: CyclePageControl = {
        
        let pageControl: CyclePageControl = CyclePageControl(frame: CGRect(x: 0, y: self.frame.size.height - 20, width: self.frame.size.width, height: 20))
        
        pageControl.numberOfPages = self.pictures.count
        
        pageControl.backgroundColor = UIColor.clear
        
        pageControl.currentPage = 0
        
        self.addSubview(pageControl)
        
        return pageControl
    }()
}

extension CyclePicturePlayView: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CyclePictureCellIdentifier, for: indexPath) as! CyclePictureViewCell
        cell.displayImage(image: pictures[indexPath.row])
        return cell
    }
}

class CyclePictureViewCell: UICollectionViewCell {
    let imageView: UIImageView = UIImageView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        imageView.contentMode = .scaleAspectFill
        self.contentView.addSubview(imageView)
    }
    
    func displayImage(image: String) {
//        imageView.af_setImage(withURL: URL(string: image)!, placeholderImage: UIImage(named: "icon_tabbar_me_nor"), filter: nil, progress: nil, progressQueue: DispatchQueue.global(), imageTransition: .noTransition, runImageTransitionIfCached: true, completion: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public class CyclePageControl: UIPageControl {
    
    /// 设置高亮显示图片
    public var currentPageIndicatorImage: UIImage? {
        
        didSet {
            
             self.currentPageIndicatorTintColor = UIColor.clear
        }
    }
    
    /// 设置默认显示图片
    public var pageIndicatorImage: UIImage? {
        
        didSet {
            
            self.pageIndicatorTintColor = UIColor.clear
        }
    }
    
    public override var currentPage: Int {
        
        willSet {
            
            self.updateDots()
        }
    }
    
    internal func updateDots() {
        
        if self.currentPageIndicatorImage != nil || self.pageIndicatorImage != nil {
            
            for (index, dot) in self.subviews.enumerated() {
                
                if dot.subviews.count == 0 {
                    
                    let imageView: UIImageView = UIImageView()
                    
                    imageView.frame = dot.bounds

                    dot.addSubview(imageView)
                }
                    
                if let imageView = dot.subviews[0] as? UIImageView {

                    imageView.image = self.currentPage == index ? self.currentPageIndicatorImage ?? UIImage() : self.pageIndicatorImage ?? UIImage()
                }
            }
        }
    }
    
    public override init(frame: CGRect) {
        
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
