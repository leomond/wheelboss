//
//  WheelColorValue.swift
//  WheelBossDesign
//
//  Created by 李秋声 on 16/3/23.
//  Copyright © 2016年 Leomond. All rights reserved.
//

import UIKit

class WheelColorValue: UIView {

    var display = UILabel()
    var image = UIImageView()
    
    var height: CGFloat = 44

    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        display.frame = CGRectMake(0, 0, bounds.size.width, height)
        display.adjustsFontSizeToFitWidth = true
        addSubview(display)
        
        image.frame = CGRectMake(0, height, bounds.size.height - height, bounds.size.height - height)
        addSubview(image)
    }

}
