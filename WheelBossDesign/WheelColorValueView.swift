//
//  WheelColorValueView.swift
//  WheelBossDesign
//
//  Created by 李秋声 on 16/2/27.
//  Copyright © 2016年 Leomond. All rights reserved.
//

import UIKit

class WheelColorValueView: UIView {

    var wheelType = UILabel() {didSet {setNeedsDisplay()}}
    var colorView = UIImageView()
    var colorValue = UILabel()
    var color: String = "0" {didSet {setNeedsDisplay()}}
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        let size: CGSize = wheelType.sizeThatFits(wheelType.frame.size)
        wheelType.frame = CGRectMake(0, (bounds.size.height - size.height) / 2, size.width, size.height)
        addSubview(wheelType)
        var offsetX: CGFloat = 0
        if color == "0" {
            colorView.removeFromSuperview()
        } else {
            offsetX = size.height
            colorView.frame = CGRectMake(size.width, (bounds.size.height - size.height) / 2, size.height, size.height)
            colorView.image = UIImage(named: color)
            addSubview(colorView)
        }
        colorValue.frame = CGRectMake(size.width + offsetX, (bounds.size.height - size.height) / 2, bounds.size.width - size.width - size.height, size.height)
        if let colorName = WheelColorInfo.Colors[color] {
            colorValue.text = " " + colorName
        }
        addSubview(colorValue)
    }

}
