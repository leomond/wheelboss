//
//  SelectInputView.swift
//  WheelBossDesign
//
//  Created by 李秋声 on 16/2/23.
//  Copyright © 2016年 Leomond. All rights reserved.
//

import UIKit

protocol SelectInputViewDataSource: class {
    func doPulldownAction(viewObject: SelectInputView)
}

class SelectInputView: UIView {
    
    var leftSpace: CGFloat = 10 {didSet {setNeedsDisplay()}}
    
    var input = UITextField()
    
    var pulldown = PullDownView()
    
    var pulldownWidth: CGFloat = 44
    
    weak var dataSource: SelectInputViewDataSource?
    
    var id: String = ""

    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        input.frame = CGRectMake(leftSpace, 0, bounds.size.width - leftSpace - pulldownWidth, bounds.size.height)
        addSubview(input)
        
        if pulldown.frame.origin == CGPointZero {
            pulldown.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "doPulldown"))
        }
        pulldown.backgroundColor = UIColor.clearColor()
        pulldown.frame = CGRectMake(bounds.size.width - pulldownWidth, 0, pulldownWidth, bounds.size.height)
        addSubview(pulldown)
        
        layer.masksToBounds = true
        layer.cornerRadius = 4.5
    }
    
    
    func doPulldown() {
        dataSource?.doPulldownAction(self)
    }

}
