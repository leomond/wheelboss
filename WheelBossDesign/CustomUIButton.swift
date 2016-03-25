//
//  CustomUIButton.swift
//  WheelBossDesign
//
//  Created by 李秋声 on 16/1/28.
//  Copyright © 2016年 Leomond. All rights reserved.
//

import UIKit

//@IBDesignable
class CustomUIButton: UIButton {
    
//    @IBInspectable
    var borderWidth: CGFloat = 1 {didSet {setNeedsDisplay()}}
    
//    @IBInspectable
    var cornerRadius: CGFloat = 4.5 {didSet {setNeedsDisplay()}}
    
//    @IBInspectable
    var borderColor: UIColor = UIColor.whiteColor() {didSet {setNeedsDisplay()}}

    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        layer.borderWidth = borderWidth
        layer.cornerRadius = cornerRadius
        layer.borderColor = borderColor.CGColor
    }
    

}
