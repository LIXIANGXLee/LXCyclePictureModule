//
//  LXCyclePictureProtocol.swift
//  LXCyclePictureModule
//
//  Created by Mac on 2020/5/2.
//  Copyright © 2020 李响. All rights reserved.
//

import UIKit

// MARK: - 协议 数据
public protocol LXCyclePictureProtocol {

    /// 图片 url
    var imgUrl: String { get set }
       
    /// 点击图片详情 url
    var descUrl: String { get set }
    
}
