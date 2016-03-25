//
//  OrderConfirmModuleView.swift
//  WheelBossDesign
//
//  Created by 李秋声 on 16/2/22.
//  Copyright © 2016年 Leomond. All rights reserved.
//

import UIKit

class OrderModuleView: UIView {
    
    var titleView = UIView() {didSet {setNeedsDisplay()}}
    
    var bodyView = UIView() {didSet {setNeedsDisplay()}}
    
    var titleHeight: CGFloat = 40
    
    var bodyLeftSpace: CGFloat = 80
    
    var bodyRightSpace: CGFloat = 80

    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        titleView.frame = CGRectMake(0, 0, bounds.size.width, titleHeight)
        titleView.backgroundColor = UIColor.clearColor()
        addSubview(titleView)
        
        let bodyWidth = bounds.size.width - bodyLeftSpace - bodyRightSpace
        bodyView.frame = CGRectMake(bodyLeftSpace, titleHeight, bodyWidth, bounds.size.height - titleHeight)
        bodyView.backgroundColor = UIColor.clearColor()
        addSubview(bodyView)
    }

}
