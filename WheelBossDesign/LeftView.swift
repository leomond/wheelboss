//
//  LeftView.swift
//  WheelBossDesign
//
//  Created by 李秋声 on 16/2/8.
//  Copyright © 2016年 Leomond. All rights reserved.
//

import UIKit

class LeftView: UIView {

    var storeImage: UIImageView = UIImageView()
    
    var storeLabel: UILabel = UILabel()
    
    var leftList: MineLeftListView = MineLeftListView()
    
    var topSpace: CGFloat = 40
    var imageLeftSpace: CGFloat = 40
    var storeNameHeight: CGFloat = 60
    var split: CGFloat = 10
    
    var storeImageName: String = "default-store" {didSet {setNeedsDisplay()}}
    var storeName: String = "" {didSet {setNeedsDisplay()}}
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        let linePath = UIBezierPath()
        linePath.moveToPoint(CGPoint(x: bounds.size.width, y: 0))
        linePath.addLineToPoint(CGPoint(x: bounds.size.width, y: bounds.size.height))
        linePath.lineWidth = 1
        UIColor.grayColor().set()
        linePath.stroke()
        let width: CGFloat = bounds.size.width - imageLeftSpace * 2
        storeImage.frame = CGRectMake(imageLeftSpace, topSpace, width, width)
        storeImage.image = UIImage(named: storeImageName)
        storeImage.layer.cornerRadius = width / 2
        storeImage.layer.masksToBounds = true
        addSubview(storeImage)
        
        storeLabel.text = storeName
        storeLabel.textAlignment = .Center
        storeLabel.frame = CGRectMake(imageLeftSpace, topSpace + width, width, storeNameHeight)
        storeLabel.font = UIFont.systemFontOfSize(20)
        storeLabel.adjustsFontSizeToFitWidth = true
        storeLabel.numberOfLines = 0
        addSubview(storeLabel)
        
        let y: CGFloat = topSpace + width + storeNameHeight + split
        leftList.frame = CGRectMake(0, y, bounds.size.width, bounds.size.height - y)
        leftList.backgroundColor = UIColor.clearColor()
        addSubview(leftList)
    }
    

}
