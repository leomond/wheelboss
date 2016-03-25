//
//  ComingSoonView.swift
//  WheelBossDesign
//
//  Created by 李秋声 on 16/3/12.
//  Copyright © 2016年 Leomond. All rights reserved.
//

import UIKit

class ComingSoonView: UIView {
    
    var label = UILabel()

    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        label.text = "敬请期待"
        label.textAlignment = .Center
//        let newsize = label.sizeThatFits(label.frame.size)
        let width: CGFloat = 100
        let height: CGFloat = 44
        label.frame = CGRectMake((bounds.size.width - width) / 2, (bounds.size.height - height) / 2, width, height)
        addSubview(label)
    }

}
