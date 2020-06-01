//
//  LXCyclePictureConfig.swift
//  LXCyclePictureModule
//
//  Created by Mac on 2020/5/2.
//  Copyright © 2020 李响. All rights reserved.
//

import UIKit
import LXFitManager

public struct LXCyclePictureConfig {

    public init(pageControlX: CGFloat = 0,
                pageControlY: CGFloat = LXFit.fitFloat(160),
                pageControlW: CGFloat = UIScreen.main.bounds.width,
                 pageControlH: CGFloat = LXFit.fitFloat(20),
                 pageIndicatorTintColor: UIColor = UIColor.lightGray,
                 currentPageIndicatorTintColor: UIColor = UIColor.orange,
                 sectionCount: Int = 20,
                 isPicScrollEnable: Bool = true) {
        self.pageControlX = pageControlX
        self.pageControlY = pageControlY
        self.pageControlH = pageControlH
        self.pageControlW = pageControlW
        self.pageIndicatorTintColor = pageIndicatorTintColor
        self.currentPageIndicatorTintColor = currentPageIndicatorTintColor
        self.sectionCount = sectionCount
        self.isPicScrollEnable = isPicScrollEnable
    }
    
   public var pageControlY: CGFloat
   public var pageControlX: CGFloat
    /// 375 是一个基准数字
   public var pageControlW: CGFloat
   public var pageControlH: CGFloat
   public var pageIndicatorTintColor: UIColor
   public var currentPageIndicatorTintColor: UIColor

   ///collectionView 几组 (推荐20组，建议不要改)
   public var sectionCount: Int
    
   /// 判断是否允许手动滚动视图
   public var isPicScrollEnable: Bool
}
