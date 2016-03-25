//
//  TextFieldView.swift
//  WheelBossDesign
//
//  Created by 李秋声 on 16/2/23.
//  Copyright © 2016年 Leomond. All rights reserved.
//

import UIKit

class TextFieldView: UIView {
    
    var leftSpace: CGFloat = 10
    
    var input = UITextField()

    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        input.frame = CGRectMake(leftSpace, 0, bounds.size.width - leftSpace, bounds.size.height)
        addSubview(input)
        layer.masksToBounds = true
        layer.cornerRadius = 4.5
    }

}
