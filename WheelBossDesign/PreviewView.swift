//
//  PreviewView.swift
//  WheelBossDesign
//
//  Created by 李秋声 on 16/2/8.
//  Copyright © 2016年 Leomond. All rights reserved.
//

import UIKit

class PreviewView: UIView {

    //轮辋
    var lw: UIImageView = UIImageView()  {didSet {setNeedsDisplay()}}
    
    //轮辐
    var lf: UIImageView = UIImageView()  {didSet {setNeedsDisplay()}}
    
    //轮缘
    var ly: UIImageView = UIImageView()  {didSet {setNeedsDisplay()}}
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        lw.frame = CGRectMake(0, 0, bounds.size.width, bounds.size.height)
        addSubview(lw)
        
        lf.frame = CGRectMake(0, 0, bounds.size.width, bounds.size.height)
        addSubview(lf)
        
        ly.frame = CGRectMake(0, 0, bounds.size.width, bounds.size.height)
        addSubview(ly)
    }

}
