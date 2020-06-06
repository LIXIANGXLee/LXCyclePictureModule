//
//  LXCyclePictureCell.swift
//  LXCyclePictureModule
//
//  Created by Mac on 2020/5/2.
//  Copyright © 2020 李响. All rights reserved.
//

import UIKit

public typealias LoadBlock = ((LXCyclePictureProtocol, UIImageView) -> ())

// MARK: - cell
public class LXCyclePictureCell: UICollectionViewCell {
    
   fileprivate var imgView: UIImageView = UIImageView()
   fileprivate var imgViewLeftRightMargin: CGFloat = 0
   fileprivate var imgViewCornerRadius: CGFloat = 0
    
    /// public 数据源
   public var picModel: LXCyclePictureProtocol? {
        didSet {
            guard let model = picModel else { return }
            loadBlock?(model,imgView)
        }
    }
    
    /// 用于加载图片的代码块, 必须赋值
   public var loadBlock: LoadBlock?

      // MARK: - system
   public override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        addSubview(imgView)
        imgView.clipsToBounds = true
    }
    
   public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        imgView.frame = CGRect(x: self.imgViewLeftRightMargin, y: 0, width: bounds.width - self.imgViewLeftRightMargin * 2, height: bounds.height)
    }
    
    public func setImgView(cornerRadius: CGFloat, margin: CGFloat) {
        self.imgViewCornerRadius = cornerRadius
        self.imgViewLeftRightMargin = margin
        imgView.layer.cornerRadius = cornerRadius
        setNeedsLayout()
    }
    
}
