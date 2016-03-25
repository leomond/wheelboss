//
//  ColorView.swift
//  WheelBossDesign
//
//  Created by 李秋声 on 16/2/19.
//  Copyright © 2016年 Leomond. All rights reserved.
//

import UIKit

protocol ColorViewDataSource: class {
    func selectColorForWheel(colorName: String)
}

class ColorView: UIView {
    
    var color: UIImageView = UIImageView()
    
    var label = UILabel()
    
    var colorNamed: String = "" {didSet {setNeedsDisplay()}}
    
    var labelHeight: CGFloat = 24
    
    var labelSpace: CGFloat = 5
    
    var showColorName: Bool = false {
        didSet {
            updateLabel()
        }
    }
    
    weak var dataSource: ColorViewDataSource?

    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        color.image = UIImage(named: colorNamed)
        color.frame = CGRectMake(0, 0, bounds.size.width, bounds.size.height)
        addSubview(color)
        
        updateLabel()
    }
    
    func updateLabel() {
        if showColorName {
            label.text = WheelColorInfo.Colors[colorNamed]
            label.textAlignment = .Center
            label.font = UIFont.systemFontOfSize(14)
            label.frame = CGRectMake(labelSpace, bounds.size.height - labelHeight - labelSpace, bounds.size.width - labelSpace * 2, labelHeight)
            label.backgroundColor = UIColor.whiteColor()
            label.layer.masksToBounds = true
            label.layer.cornerRadius = 5
            addSubview(label)
        } else {
            label.removeFromSuperview()
        }
    }
    
    func tapColor() {
        dataSource?.selectColorForWheel(colorNamed)
    }

}
