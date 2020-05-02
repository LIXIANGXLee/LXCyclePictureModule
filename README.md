# LXCyclePictureManager

#### 项目介绍
 **

### 最完美、最轻量级的  轮播图  （ 图片加载方式可以自定义）
** 

#### 安装说明
方式1 ： cocoapods安装库 
        ** pod 'LXCyclePictureManager' **
        ** pod install ** 

方式2:   **直接下载压缩包 解压**    **LXCyclePictureManager **   

#### 使用说明
 **下载后压缩包 解压   请先 pod install  在运行项目** 
  
  ### 基本使用方式（点击回调可以设置代理）
```
var config = LXCyclePictureConfig()
let cyclePictureView =  LXCyclePictureView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: LXFit.fitFloat(260)), config: config)
cyclePictureView.delegate = self
cyclePictureView.loadBlock = {
    (model, imgView) -> () in
    imgView.kf.setImage(with: URL(string: model.imgUrl))
}

 self.cyclePictureView.picModels = [LXCyclePictureProtocol]
 
```

