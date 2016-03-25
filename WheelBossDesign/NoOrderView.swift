//
//  NoOrderView.swift
//  WheelBossDesign
//
//  Created by 李秋声 on 16/2/14.
//  Copyright © 2016年 Leomond. All rights reserved.
//

import UIKit

class NoOrderView: UIView {
    
    var label: UILabel = UILabel()
    
    var pictureView: UIImageView = UIImageView()
    
    var pictureViewWidth: CGFloat = 241
    
    var pictureViewHeight: CGFloat = 164
    
    var picutre: String = "shoppingcart" {didSet {setNeedsDisplay()}}
    
    var content: String = "你没有任何的订单信息" {didSet {setNeedsDisplay()}}
    
    var labelHeight: CGFloat = 44
    
    var upSpace: CGFloat = 60

    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        pictureView.image = UIImage(named: picutre)
        pictureView.frame = CGRectMake((bounds.size.width - pictureViewWidth) / 2, (bounds.size.height - pictureViewHeight ) / 2 - upSpace, pictureViewWidth, pictureViewHeight)
        addSubview(pictureView)
        
        label.text = content
        label.frame = CGRectMake(0, (bounds.size.height + pictureViewHeight ) / 2 - upSpace, bounds.size.width, labelHeight)
        label.font = UIFont(name: "ArialMT", size: 18)
        label.textColor = UIColor(red: 153 / 255, green: 153 / 255, blue: 153 / 255, alpha: 1)
        label.textAlignment = .Center
        addSubview(label)
    }

}
