//
//  PicturesBodyCellView.swift
//  WheelBossDesign
//
//  Created by 李秋声 on 16/3/20.
//  Copyright © 2016年 Leomond. All rights reserved.
//

import UIKit

protocol PicturesBodyCellViewDataSource: class {
    func doViewLarge(pictureInfo: PicturesInfo)
}

class PicturesBodyCellView: UIView {
    
    var info: PicturesInfo = PicturesInfo() {didSet{setNeedsDisplay()}}
    
    var image: UIImageView = UIImageView()
    
    weak var dataSource: PicturesBodyCellViewDataSource?

    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        image.frame = CGRectMake(0, 0, bounds.size.width, bounds.size.height)
        let imgURL:NSURL=NSURL(string: info.listUrl)!
        let request:NSURLRequest=NSURLRequest(URL:imgURL)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(),
            completionHandler: {(response, data, error)->Void in
                if data != nil {
                    let img=UIImage(data:data!)
                    self.image.image = img
                }
                
        })
        addSubview(image)
    }
    
    func viewLarger() {
        dataSource?.doViewLarge(info)
    }

}
