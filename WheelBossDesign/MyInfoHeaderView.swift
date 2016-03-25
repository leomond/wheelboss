//
//  MyInfoHeaderView.swift
//  WheelBossDesign
//
//  Created by 李秋声 on 16/3/6.
//  Copyright © 2016年 Leomond. All rights reserved.
//

import UIKit

protocol MyInfoHeaderViewDataSource: class {
    func clickMyInfoHeadState(state: String)
}

class MyInfoHeaderView: UIView {
    var head: [String] = ["基本信息", "密码管理"]
    var buttons: Dictionary<String, UIButton> = Dictionary<String, UIButton>()
    var buttonHeight: CGFloat = 44 {didSet {setNeedsDisplay()}}
    var splitWidth: CGFloat = 2 {didSet {setNeedsDisplay()}}
    var spaceHorizon: CGFloat = 10 {didSet {setNeedsDisplay()}}
    var splitSpace: CGFloat = 10 {didSet {setNeedsDisplay()}}
    var focusButton: String = "基本信息" {didSet {setNeedsDisplay()}}
    
    weak var dataSource:MyInfoHeaderViewDataSource?
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        let space: CGFloat = (bounds.size.height - buttonHeight) / 2
        let buttonWidth: CGFloat = (bounds.size.width - spaceHorizon * CGFloat(head.count * 2) - splitWidth * CGFloat(head.count - 1)) / CGFloat(head.count)
        var index: Int = 0
        for status in head {
            let button: UIButton = buttons[status] ?? UIButton(type: UIButtonType.Custom)
            if button.frame.origin.x == 0 {
                button.addTarget(self, action: Selector("clicked:"), forControlEvents: .TouchUpInside)
            }
            let buttonX: CGFloat = spaceHorizon * CGFloat(2 * index + 1) + (splitWidth + buttonWidth) * CGFloat(index)
            button.frame = CGRectMake(buttonX, space, buttonWidth, buttonHeight)
            button.setTitle(status, forState: UIControlState.Normal)
            if focusButton == status {
                button.setTitleColor(UIColor(red: 200 / 255, green: 35 / 255, blue: 42 / 255, alpha: 1), forState: UIControlState.Normal)
            } else {
                button.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
            }
            button.titleLabel?.font = UIFont.systemFontOfSize(20)
            buttons[status] = button
            addSubview(button)
            if index != head.count - 1 {
                let path = UIBezierPath()
                let lineX: CGFloat = buttonX + buttonWidth + spaceHorizon
                path.moveToPoint(CGPoint(x: lineX, y: splitSpace))
                path.addLineToPoint(CGPoint(x: lineX, y: bounds.size.height - splitSpace))
                path.lineWidth = splitWidth
                UIColor.grayColor().set()
                path.stroke()
            }
            index++
        }
    }
    
    func clicked(button: UIButton) {
        focusButton = button.titleForState(UIControlState.Normal)!
        dataSource?.clickMyInfoHeadState(focusButton)
    }
}
