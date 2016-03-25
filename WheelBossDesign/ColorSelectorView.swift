//
//  ColorSelectorView.swift
//  WheelBossDesign
//
//  Created by 李秋声 on 16/2/8.
//  Copyright © 2016年 Leomond. All rights reserved.
//

import UIKit

protocol ColorSelectorViewDataSource: class {
    func selectColor(colorName: String)
}

class ColorSelectorView: UIView, ColorViewDataSource {
    
    weak var dataSource: ColorSelectorViewDataSource?
    
    var colors: [String] = [] {
        didSet {
            for (_, view) in colorViews {
                view.removeFromSuperview()
            }
            colorViews = Dictionary<String, ColorView>()
            setNeedsDisplay()
        }
    }
    
    var colorViews: Dictionary<String, ColorView> = Dictionary<String, ColorView>()
    
    var space: CGFloat = 20
    
    var countPerLine: Int = 3
    
    var selectedColorName: String? {
        didSet {
            for (_, value) in colorViews {
                if value.colorNamed == selectedColorName {
                    value.showColorName = true
                } else {
                    value.showColorName = false
                }
            }
        }
    }

    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        let colorSide: CGFloat = (bounds.size.width - space * CGFloat(countPerLine + 1)) / CGFloat(countPerLine)
        var index: Int = 0
        for color in colors {
            let colorView: ColorView = ColorView()
            colorView.addGestureRecognizer(UITapGestureRecognizer(target: colorView, action: "tapColor"))
            colorView.dataSource = self
            colorView.colorNamed = color
            colorView.backgroundColor = UIColor.clearColor()
            let line: Int = index / countPerLine
            let coloumn: Int = index % countPerLine
            colorView.frame = CGRectMake(space * CGFloat(coloumn + 1) + colorSide * CGFloat(coloumn), space * CGFloat(line + 1) + colorSide * CGFloat(line), colorSide, colorSide)
            colorViews[color] = colorView
            if selectedColorName == color {
                colorView.showColorName = true
            } else {
                colorView.showColorName = false
            }
            addSubview(colorView)
            index++
        }
    }
    
    func selectColorForWheel(colorName: String) {
        selectedColorName = colorName
        dataSource?.selectColor(colorName)
    }

}
