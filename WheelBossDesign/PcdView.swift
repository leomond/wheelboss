//
//  PcdView.swift
//  WheelBossDesign
//
//  Created by 李秋声 on 16/2/23.
//  Copyright © 2016年 Leomond. All rights reserved.
//

import UIKit

class PcdView: UIView {
    
    var count = TextFieldView()
    
    var symbl = UILabel()
    
    var symblWidth: CGFloat = 20
    
    var value = TextFieldView()

    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        let countWidth = bounds.size.height
        count.backgroundColor = UIColor.groupTableViewBackgroundColor()
        count.frame = CGRectMake(0, 0, countWidth, bounds.size.height)
        count.input.keyboardType = .NumberPad
        addSubview(count)
        
        symbl.text = "×"
        symbl.textAlignment = .Center
        symbl.font = UIFont.systemFontOfSize(20)
        symbl.frame = CGRectMake(countWidth, 0, symblWidth, bounds.size.height)
        addSubview(symbl)
        
        value.backgroundColor = UIColor.groupTableViewBackgroundColor()
        value.frame = CGRectMake(countWidth + symblWidth, 0, bounds.size.width - countWidth - symblWidth, bounds.size.height)
        value.input.keyboardType = .DecimalPad
        addSubview(value)
    }

}
