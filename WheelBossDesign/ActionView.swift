//
//  ActionView.swift
//  WheelBossDesign
//
//  Created by 李秋声 on 16/2/7.
//  Copyright © 2016年 Leomond. All rights reserved.
//

import UIKit

protocol ActionViewDataSource: class {
    func changeWheelColor(component: String, colorName: String)
}

class ActionView: UIView, ColorSelectorViewDataSource {
    
    var buttonsTitle: [String] = [String]() {didSet{setNeedsDisplay()}}
    
    var buttons: Dictionary<String, UIButton> = Dictionary<String, UIButton>()
    
    var buttonSpace: CGFloat = 20
    
    var buttonHeight: CGFloat = 44
    
    var lineWidth: CGFloat = 2
    
    var lineColor: UIColor = UIColor(red: 153 / 255, green: 153 / 255, blue: 153 / 255, alpha: 0.8)
    
    var bottomButtonHeight: CGFloat = 60
    
    var resetButton: UIButton = UIButton()
    
    var orderButton: UIButton = UIButton()
    
    var colorSelectors: Dictionary<String, ColorSelectorView> = Dictionary<String, ColorSelectorView>()
    
    var focusedButton: String = "轮辋" {didSet {setNeedsDisplay()}}
    
    weak var dataSource: ActionViewDataSource?
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        drawTopButtons()
        
        drawSplitLine()
        
        drawLeftViewBorder()
        
        drawColorBody()
        
        drawButtonButtons()
    }
    
    func drawColorBody() {
        for (key, selector) in colorSelectors {
            if key != focusedButton {
                selector.removeFromSuperview()
            }
        }
        let colorSelector = colorSelectors[focusedButton] ?? ColorSelectorView()
        if colorSelector.frame.origin == CGPointZero {
            colorSelector.dataSource = self
        }
        let colorSelectorY: CGFloat = buttonHeight + buttonSpace * 3 + lineWidth
        colorSelector.frame = CGRectMake(buttonSpace, colorSelectorY, bounds.size.width - buttonSpace * 2, bounds.size.height - colorSelectorY - buttonSpace * 2 - bottomButtonHeight)
        colorSelector.backgroundColor = UIColor.clearColor()
        colorSelectors[focusedButton] = colorSelector
        colorSelectors[focusedButton]?.colors = getColors()
        addSubview(colorSelector)
    }
    
    func drawButtonButtons() {
        let bottomButtonWidth: CGFloat = (bounds.size.width - buttonSpace * 3) / 2
        resetButton.frame = CGRectMake(buttonSpace, bounds.size.height - bottomButtonHeight - buttonSpace, bottomButtonWidth, bottomButtonHeight)
        resetButton.setTitleColor(UIColor(red: 153 / 255, green: 153 / 255, blue: 153 / 255, alpha: 1), forState: UIControlState.Normal)
        resetButton.setTitle("重置", forState: .Normal)
        resetButton.setBackgroundImage(UIImage(named: "design-reset"), forState: UIControlState.Normal)
        addSubview(resetButton)
        
        orderButton.frame = CGRectMake(buttonSpace * 2 + bottomButtonWidth, bounds.size.height - bottomButtonHeight - buttonSpace, bottomButtonWidth, bottomButtonHeight)
        orderButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        orderButton.setTitle("下单", forState: .Normal)
        orderButton.setBackgroundImage(UIImage(named: "design-order"), forState: UIControlState.Normal)
        addSubview(orderButton)
    }
    
    func drawLeftViewBorder() {
        let leftViewBoder = UIBezierPath()
        leftViewBoder.moveToPoint(CGPointZero)
        leftViewBoder.addLineToPoint(CGPoint(x: 0, y: bounds.size.height))
        leftViewBoder.lineWidth = 1
        lineColor.set()
        leftViewBoder.stroke()
    }
    
    func drawSplitLine() {
        let linePath = UIBezierPath()
        let lineY: CGFloat = buttonSpace * 2 + buttonHeight
        linePath.moveToPoint(CGPoint(x: buttonSpace / 2, y: lineY))
        linePath.addLineToPoint(CGPoint(x: bounds.size.width - buttonSpace / 2,y: lineY))
        linePath.lineWidth = lineWidth
        lineColor.set()
        linePath.stroke()
    }
    
    func drawTopButtons() {
        let buttonCount: Int = buttonsTitle.count
        let buttonWidth: CGFloat = (bounds.size.width - CGFloat(buttonCount + 1) * buttonSpace) / CGFloat(buttonCount)
        for var index: Int = 0; index < buttonCount; index++ {
            let buttonX: CGFloat = buttonSpace * CGFloat(index + 1) + buttonWidth * CGFloat(index)
            let button: UIButton = buttons[buttonsTitle[index]] ?? UIButton()
            if button.frame.origin == CGPointZero {
                button.addTarget(self, action: "changedTab:", forControlEvents: UIControlEvents.TouchUpInside)
            }
            button.frame = CGRectMake(buttonX, buttonSpace, buttonWidth, buttonHeight)
            button.setTitle(buttonsTitle[index], forState: UIControlState.Normal)
            if buttonsTitle[index] == focusedButton {
                button.setTitleColor(UIColor(red: 16 / 255, green: 17 / 255, blue: 19 / 255, alpha: 1), forState: UIControlState.Normal)
                button.setBackgroundImage(UIImage(named: "design-selectedbutton"), forState: UIControlState.Normal)
            } else {
                button.setTitleColor(UIColor(red: 153 / 255, green: 153 / 255, blue: 153 / 255, alpha: 1), forState: UIControlState.Normal)
                button.setBackgroundImage(UIImage(named: "design-unselectedbutton"), forState: UIControlState.Normal)
            }
            buttons[buttonsTitle[index]] = button
            addSubview(button)
        }
    }
    
    func changedTab(button: UIButton) {
        focusedButton = button.titleForState(.Normal)!
    }
    
    func getColors() -> [String] {
        switch focusedButton {
        case "轮缘":
            return ["1", "2", "3", "4", "5", "6", "10", "11", "12", "13", "14", "15"]
        case "轮辐":
            return ["1", "2", "3", "4", "5", "6", "10", "11", "12", "13", "14", "15"]
        default:
            return ["1", "2", "3", "4", "5", "6", "10", "11", "12", "13", "14", "15"]
        }
    }
    
    func selectColor(colorName: String) {
        dataSource?.changeWheelColor(focusedButton, colorName: colorName)
    }

}
