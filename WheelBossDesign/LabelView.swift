//
//  LabelView.swift
//  WheelBossDesign
//
//  Created by 李秋声 on 16/2/23.
//  Copyright © 2016年 Leomond. All rights reserved.
//

import UIKit

class LabelView: UIView {
    
    var paddingRight: CGFloat = 10
    
    var label = UILabel()
    
    var textAlignment:NSTextAlignment = .Right
    
    var textColor: UIColor = UIColor(red: 16 / 255, green: 17 / 255, blue: 19 / 255, alpha: 1)
    
    var text: String = ""

    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        label.text = text
        label.textAlignment = textAlignment
        label.textColor = textColor
        label.numberOfLines = 0
        label.font = UIFont(name: "ArialMT", size: 14)
        label.frame = CGRectMake(0, 0, bounds.size.width - paddingRight, bounds.size.height)
        addSubview(label)
    }

}
