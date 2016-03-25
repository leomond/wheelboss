//
//  MyBusinessView.swift
//  WheelBossDesign
//
//  Created by 李秋声 on 16/2/21.
//  Copyright © 2016年 Leomond. All rights reserved.
//

import UIKit

class MyBusinessView: UIView {
    
    var leftView = LeftView() {didSet{setNeedsDisplay()}}
    
    var rightView = RightView()
    
    var leftRatio: CGFloat = 0.25

    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        leftView.backgroundColor = UIColor.clearColor()
        leftView.frame = CGRectMake(0, 0, bounds.size.width * leftRatio, bounds.size.height)
        addSubview(leftView)
        
        rightView.backgroundColor = UIColor.groupTableViewBackgroundColor()
        rightView.frame = CGRectMake(bounds.size.width * leftRatio, 0, bounds.size.width * (1 - leftRatio), bounds.size.height)
        rightView.layer.shadowOffset = CGSizeZero
        rightView.layer.shadowColor = UIColor.grayColor().CGColor
        rightView.layer.shadowOpacity = 0.6
        rightView.layer.shadowRadius = 2
        rightView.layer.shadowPath = fancyShadowForRect(rightView.layer.bounds)
        addSubview(rightView)
    }
    
    private func fancyShadowForRect(rect: CGRect) -> CGPathRef {
        let size: CGSize = rect.size
        let path = UIBezierPath()
        path.moveToPoint(CGPoint(x: -4, y: 0))
        path.addLineToPoint(CGPoint(x: 0, y: 0))
        path.addLineToPoint(CGPoint(x: 0, y: size.height))
        path.addLineToPoint(CGPoint(x: -4, y: size.height))
        path.closePath()
        return path.CGPath
    }

}
