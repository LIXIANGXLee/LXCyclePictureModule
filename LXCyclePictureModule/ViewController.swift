//
//  ViewController.swift
//  LXCyclePictureModule
//
//  Created by Mac on 2020/5/2.
//  Copyright © 2020 李响. All rights reserved.
//

import UIKit
import LXFitManager
import LXCyclePictureManager

class ViewController: UIViewController {
    
    fileprivate lazy var cyclePictureView: LXCyclePictureView = {
        var config = LXCyclePictureConfig()
//        config.imgViewCornerRadius = 10
//        config.imgViewLeftRightMargin = 20

        let cyclePictureView =  LXCyclePictureView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: LXFit.fitFloat(180) ), config: config)
         cyclePictureView.loadBlock = {
            (model, imgView) -> () in
            imgView.kf.setImage(with: URL(string: model.imgUrl))
        }
        return cyclePictureView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(cyclePictureView)
                
        self.cyclePictureView.picModels = [Model(imgUrl: "https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1588427837&di=e90592537b23fa87fbdc1e5b89b4a411&src=http://image.biaobaiju.com/uploads/20181004/14/1538635023-zLwSVgjcrP.jpg", descUrl: ""),Model(imgUrl: "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1588437920242&di=b7de70ed46148a4186f5f6ca11b778e7&imgtype=0&src=http%3A%2F%2Fwww.ztkm.com%2Fuploads%2Fallimg%2F120419%2F2-120419152946.jpg", descUrl: "")]

    }


}

struct Model: LXCyclePictureProtocol {
    var imgUrl: String = ""
    var descUrl: String = ""
}
