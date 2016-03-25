//
//  DesignBodyView.swift
//  WheelBossDesign
//
//  Created by 李秋声 on 16/2/7.
//  Copyright © 2016年 Leomond. All rights reserved.
//

import UIKit

class DesignBodyView: UIView {
    
    var diagram: DiagramView = DiagramView()
    
    var action: ActionView = ActionView()
    
    var actionWidthRatio: CGFloat = 0.4
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        let actionWidth = bounds.size.width * actionWidthRatio
        diagram.frame = CGRectMake(0, 0, bounds.size.width - actionWidth, bounds.size.height)
        diagram.backgroundColor = UIColor.clearColor()
        addSubview(diagram)
        
        action.frame = CGRectMake(bounds.size.width - actionWidth, 0, actionWidth, bounds.size.height)
        action.backgroundColor = UIColor.whiteColor()
        action.layer.shadowOffset = CGSizeZero
        action.layer.shadowColor = UIColor.grayColor().CGColor
        action.layer.shadowOpacity = 0.8
        action.layer.shadowRadius = 2
        action.layer.shadowPath = fancyShadowForRect(action.layer.bounds)
        addSubview(action)
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
