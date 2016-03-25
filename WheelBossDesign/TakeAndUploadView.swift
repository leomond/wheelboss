//
//  TakeAndUploadView.swift
//  WheelBossDesign
//
//  Created by 李秋声 on 16/2/9.
//  Copyright © 2016年 Leomond. All rights reserved.
//

import UIKit

class TakeAndUploadView: UIView {

    var label: UILabel = UILabel() {didSet {setNeedsDisplay()}}
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        label.text = "敬请期待"
        label.frame = CGRectMake((bounds.size.width - 100) / 2, (bounds.size.height - 44) / 2, 100, 44)
        addSubview(label)
    }

}
