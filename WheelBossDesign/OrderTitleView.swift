//
//  OrderConfirmTitleView.swift
//  WheelBossDesign
//
//  Created by 李秋声 on 16/2/16.
//  Copyright © 2016年 Leomond. All rights reserved.
//

import UIKit

class OrderTitleView: UIView {
    
    var title: String = "" {didSet {setNeedsDisplay()}}
    
    var titleWidth: CGFloat = 120 {didSet {setNeedsDisplay()}}
    
    var titleLabel: UILabel = UILabel()
    
    var titleIconView: UIImageView = UIImageView()
    
    var titleIconViewSide: CGFloat = 20 {didSet {setNeedsDisplay()}}
    
    var titleIcon: String = "" {didSet {setNeedsDisplay()}}
    
    var leftSpace: CGFloat = 10 {didSet {setNeedsDisplay()}}

    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        titleIconView.image = UIImage(named: titleIcon)
        titleIconView.frame = CGRectMake(leftSpace, (bounds.size.height - titleIconViewSide) / 2, titleIconViewSide, titleIconViewSide)
        addSubview(titleIconView)
        
        titleLabel.text = title
        titleLabel.textColor = UIColor(red: 200 / 255, green: 35 / 255, blue: 42 / 255, alpha: 1)
        titleLabel.font = UIFont(name: "ArialMT", size: 18)
        titleLabel.frame = CGRectMake(leftSpace * 2 + titleIconViewSide, 0, titleWidth, bounds.size.height)
        addSubview(titleLabel)
        
        let path = UIBezierPath()
        path.moveToPoint(CGPoint(x: 0, y: bounds.size.height))
        path.addLineToPoint(CGPoint(x: bounds.size.width, y: bounds.size.height))
        path.lineWidth = 1
        let dash: [CGFloat] = [1.0, 1.0]
        path.setLineDash(dash, count: 2, phase: 0)
        UIColor.grayColor().set()
        path.stroke()
    }
    
    

}
