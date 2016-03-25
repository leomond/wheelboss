//
//  PicturesHeaderView.swift
//  WheelBossDesign
//
//  Created by 李秋声 on 16/3/20.
//  Copyright © 2016年 Leomond. All rights reserved.
//

import UIKit

protocol PicturesHeaderViewDataSource: class {
    func reloadPcturesHomeBody(focusButton: String)
}

class PicturesHeaderView: UIView {
    
    var space: CGFloat = 40
    var lineWidth: CGFloat = 2
    var titles: [String] = [String]() {didSet {setNeedsDisplay()}}
    var buttons: Dictionary<String, UIButton> = Dictionary<String, UIButton>()
    var buttonHeight: CGFloat = 44
    var focusButton: String = "全拉丝" {didSet {setNeedsDisplay()}}
    let maxButtonWidth: CGFloat = 250
    
    weak var dataSource: PicturesHeaderViewDataSource?
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        if titles.count == 0 {
            return
        }
        let buttonWidth: CGFloat = min(bounds.size.width / CGFloat(titles.count), maxButtonWidth)
        let leftSpace: CGFloat = (bounds.size.width - buttonWidth * CGFloat(titles.count) - space * CGFloat(titles.count - 1)) / 2
        let buttonY: CGFloat = (bounds.size.height - buttonHeight) / 2
        var index: Int = 0
        for title in titles {
            let button = buttons[title] ?? UIButton(type: UIButtonType.Custom)
            if button.frame.origin.x == 0 {
                button.addTarget(self, action: "clickAction:", forControlEvents: UIControlEvents.TouchUpInside)
            }
            button.setTitle(title, forState: .Normal)
            if focusButton == title {
                button.setTitleColor(UIColor.blackColor(), forState: .Normal)
                button.setBackgroundImage(UIImage(named: "selectedButton"), forState: UIControlState.Normal)
            } else {
                button.setTitleColor(UIColor.grayColor(), forState: .Normal)
                button.setBackgroundImage(UIImage(named: "unselectedButton"), forState: UIControlState.Normal)
            }
            button.frame = CGRectMake(leftSpace + (buttonWidth + space) * CGFloat(index), buttonY, buttonWidth, buttonHeight)
            button.titleLabel?.font = UIFont(name: "ArialMT", size: 20)
            buttons[title] = button
            addSubview(button)
            index++
        }
    }
    
    func clickAction(button: UIButton) {
        focusButton = button.titleForState(.Normal)!
        dataSource?.reloadPcturesHomeBody(focusButton)
    }

}
