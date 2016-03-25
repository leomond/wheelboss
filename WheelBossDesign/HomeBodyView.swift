//
//  HomeBodyView.swift
//  WheelBossDesign
//
//  Created by 李秋声 on 16/2/19.
//  Copyright © 2016年 Leomond. All rights reserved.
//

import UIKit

class HomeBodyView: UIView {
    
    var leftView: HomeLeftUIView = HomeLeftUIView()
    
    var rightView: HomeRightUIView = HomeRightUIView()
    
    var leftRatio: CGFloat = 0.55

    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        leftView.frame = CGRectMake(0, 0, bounds.size.width * leftRatio, bounds.size.height)
        leftView.backgroundColor = UIColor.clearColor()
        addSubview(leftView)
        
        rightView.frame = CGRectMake(bounds.size.width * leftRatio, 0, bounds.size.width * (1 - leftRatio), bounds.size.height)
        rightView.backgroundColor = UIColor.clearColor()
        addSubview(rightView)
    }

}
