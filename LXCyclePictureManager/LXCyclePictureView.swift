//  LXCyclePictureView.swift
//  LXCyclePictureModule
//
//  Created by Mac on 2020/5/2.
//  Copyright © 2020 李响. All rights reserved.
//

// 轮播图

import UIKit

// MARK: - 协议
public protocol LXCyclePictureViewDelegate: AnyObject {
   func cyclePictureView(_ cyclePictureView: LXCyclePictureView,_ model: LXCyclePictureProtocol)
}

// MARK: - LXCyclePictureView
public class LXCyclePictureView: UIView {
    fileprivate let identified = "LXCyclePictureCell";
    fileprivate lazy var layOut: UICollectionViewFlowLayout = {
        let layOut = UICollectionViewFlowLayout()
        layOut.scrollDirection = UICollectionView.ScrollDirection.horizontal
        layOut.itemSize = CGSize(width: self.bounds.width, height: self.bounds.height)
        layOut.minimumLineSpacing = 0.01
        layOut.minimumInteritemSpacing = 0.01
        return layOut
    }()
    
    fileprivate lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height), collectionViewLayout: self.layOut)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.register(LXCyclePictureCell.self, forCellWithReuseIdentifier: identified)
        
        if #available(iOS 11.0, *) {
            collectionView.contentInsetAdjustmentBehavior = UIScrollView.ContentInsetAdjustmentBehavior.never
        }else{
         collectionView.translatesAutoresizingMaskIntoConstraints = false
        }
        return collectionView
    }()
  
    fileprivate lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl(frame: CGRect(x: self.config.pageControlX, y: self.config.pageControlY, width:  self.config.pageControlW, height: self.config.pageControlH))
        pageControl.pageIndicatorTintColor = self.config.pageIndicatorTintColor
        pageControl.currentPageIndicatorTintColor = self.config.currentPageIndicatorTintColor
        pageControl.hidesForSinglePage = true
        pageControl.isEnabled = false
        return pageControl
    }()

    /// private pageControl x,y坐标 高度
    private var config: LXCyclePictureConfig
   
    ///定时器
    fileprivate var timer: Timer?
    
    /// public 数据源
    public var picModels: [LXCyclePictureProtocol]? {
        didSet {
            guard let models = picModels else { return }
            // 设置指示器的页数
            pageControl.numberOfPages = models.count
            
            // 刷新数据
            collectionView.reloadData()
            collectionView.isScrollEnabled = ((pageControl.numberOfPages > 1) &&         self.config.isPicScrollEnable)

            // 滚到对应的中间位置
            let indexP = IndexPath(item: 0, section: self.config.sectionCount / 2)
            collectionView.scrollToItem(at: indexP, at: UICollectionView.ScrollPosition.left, animated: false)
            
            // 开启定时任务
            startTimer()
        }
    }
    ///用于加载图片的代码块, 必须赋值
    public var loadBlock: LoadBlock?
    
    ///代理
    public weak var delegate: LXCyclePictureViewDelegate?
    
    public init(frame: CGRect, config: LXCyclePictureConfig) {
        self.config = config

        super.init(frame: frame)

        backgroundColor = UIColor.white
        
        //添加滚动视图
        addSubview(collectionView)
        //添加指示器
        addSubview(pageControl)
    }
    
   public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LXCyclePictureView {
    
    ///开启定时任务
    public func startTimer() {
        guard let c = picModels?.count,c > 1 else { return  }
        if self.timer == nil{
            timer = Timer(timeInterval: 3.0, target: self, selector: #selector(autoScrollToNextPage), userInfo: nil, repeats: true)
            RunLoop.current.add(timer!, forMode: RunLoop.Mode.common)
        }
    }
    
    ///关闭定时任务
    public func removeTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    ///事件回调
   @objc private func autoScrollToNextPage() {
    
       //复位操作
        let currentMidIndexP = resetIndexPath()
       // 滚动位置
        var nextSection = currentMidIndexP.section
        var nextItem = currentMidIndexP.item + 1
        if nextItem == pageControl.numberOfPages   {
            nextSection = nextSection + 1
            nextItem = 0
        }
    
        let nextIndexP = IndexPath(item: nextItem, section: nextSection)
        collectionView.scrollToItem(at: nextIndexP, at: UICollectionView.ScrollPosition.left, animated: true)
    }
    
    ///复位操作
    private func resetIndexPath() -> IndexPath {
        //current indexpath
        guard let currentIndexPath = self.collectionView.indexPathsForVisibleItems.last else{
            return IndexPath.init(item: 0, section: self.config.sectionCount / 2)
        }
        //马上显示回最中间那组的数据
        let currentIndexPathReset = IndexPath(item: currentIndexPath.item, section: self.config.sectionCount / 2)
        self.collectionView.scrollToItem(at: currentIndexPathReset, at: .left, animated: false)
        return currentIndexPathReset
    }
}

// MARK: - UICollectionViewDelegate
extension LXCyclePictureView: UICollectionViewDelegate {

    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeTimer()
    }

    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
         startTimer()
    }
   
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = scrollView.contentOffset.x / scrollView.bounds.width + 0.5
        pageControl.currentPage = Int(page) % pageControl.numberOfPages
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.cyclePictureView(self, picModels![indexPath.item])
    }
}


// MARK: - UICollectionViewDataSource
extension LXCyclePictureView: UICollectionViewDataSource {
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.config.sectionCount
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return picModels?.count ?? 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identified, for: indexPath) as! LXCyclePictureCell
        cell.loadBlock = loadBlock
        cell.picModel = picModels?[indexPath.item]
        return cell
    }
}
