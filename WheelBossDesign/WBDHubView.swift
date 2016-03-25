//
//  WBDHubView.swift
//  WheelBossDesign
//
//  Created by 李秋声 on 16/2/14.
//  Copyright © 2016年 Leomond. All rights reserved.
//

import UIKit

protocol WBDHubViewDataSource: class {
    func doClickForDesign(wheelInfo: WheelBossInfo, focused: Bool)
}

class WBDHubView: UIView {
    
    var wheelInfo: WheelBossInfo =  WheelBossInfo() {didSet {setNeedsDisplay()}}
    
    var focusedView: Bool = false {didSet {setNeedsDisplay()}}
    
    var fontSize: CGFloat = 0
    
    var image = UIImageView()
    
    var label = UILabel()
    
    var paddingRatio: CGFloat = 0.3
    
    weak var dataSource: WBDHubViewDataSource?

    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        image.image = UIImage(named: wheelInfo.picture)
        image.frame = CGRectMake(0, 0, bounds.size.width, bounds.size.width)
        addSubview(image)
        label.text = wheelInfo.displayName
        label.textAlignment = .Center
        if focusedView {
            label.textColor = UIColor.blackColor()
        } else {
            label.textColor = UIColor.grayColor()
        }
        label.minimumScaleFactor = 0.4
        label.font = UIFont.systemFontOfSize(fontSize)
        label.adjustsFontSizeToFitWidth = true
        label.frame = CGRectMake(bounds.size.width * paddingRatio, bounds.size.width, bounds.size.width * (1 - paddingRatio * 2), bounds.size.height - bounds.size.width)
        addSubview(label)
    }
    
    func clickForDesign() {
        dataSource?.doClickForDesign(wheelInfo, focused: focusedView)
    }

}
