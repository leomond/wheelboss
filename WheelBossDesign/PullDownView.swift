//
//  PullDownView.swift
//  WheelBossDesign
//
//  Created by 李秋声 on 16/2/23.
//  Copyright © 2016年 Leomond. All rights reserved.
//

import UIKit

class PullDownView: UIView {
    
    var pulldown = UIImageView()
    
    var pulldownHeight: CGFloat = 4
    var pulldownWidth: CGFloat = 8

    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        pulldown.image = UIImage(named: "pulldown")
        pulldown.frame = CGRectMake((bounds.size.width - pulldownWidth) / 2 , (bounds.size.height - pulldownHeight) / 2, pulldownWidth, pulldownHeight)
        addSubview(pulldown)
    }

}
