//
//  HomeRightUIView.swift
//  WheelBossDesign
//
//  Created by 李秋声 on 16/1/31.
//  Copyright © 2016年 Leomond. All rights reserved.
//

import UIKit

protocol HomeRightViewDataSource: class {
    func clickAction(identifier: String)
}

//@IBDesignable
class HomeRightUIView: UIView {
    
//    @IBInspectable
    var bkgImageView: UIImageView = UIImageView() {didSet {setNeedsDisplay()}}
    
    var identifier: String = ""
    
    weak var dataSource: HomeRightViewDataSource?
    
    override func drawRect(rect: CGRect) {
        bkgImageView.frame = CGRectMake(0, 0, bounds.size.width, bounds.size.height)
        addSubview(bkgImageView)
    }
    
    func click(gesture: UITapGestureRecognizer) {
        if identifier != "" {
            dataSource?.clickAction(identifier)
        }
    }

}
