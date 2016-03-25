//
//  SelectView.swift
//  WheelBossDesign
//
//  Created by 李秋声 on 16/2/28.
//  Copyright © 2016年 Leomond. All rights reserved.
//

import UIKit

protocol SelectViewDataSource: class {
    func clickSelectView(tableData:[String], viewObject: SelectView)
}

class SelectView: UIView {

    var leftSpace: CGFloat = 10 {didSet {setNeedsDisplay()}}
    
    var display: String = "" {didSet {setNeedsDisplay()}}
    var displayTextColor = OrderConfirmInfo.DefalutOrderInfoValueTextColor
    
    var placeholder: String = "请选择"
    var placeholderTextColor = UIColor(red: 153 / 255, green: 153 / 255, blue: 153 / 255, alpha: 0.8)
    
    private var displayLabel = UILabel()
    
    var pulldown = PullDownView()
    
    var pulldownWidth: CGFloat = 44
    
    var pulldownData = [String]()
    
    private var count: Int = 0
    
    weak var dataSource: SelectViewDataSource?
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        if count == 0 {
            addGestureRecognizer(UITapGestureRecognizer(target: self, action: "doClickSelectView"))
        }
        count++
        if display == "" {
            displayLabel.text = placeholder
            displayLabel.textColor = placeholderTextColor
        } else {
            displayLabel.text = display
            displayLabel.textColor = displayTextColor
        }
        displayLabel.frame = CGRectMake(leftSpace, 0, bounds.size.width - leftSpace - pulldownWidth, bounds.size.height)
        addSubview(displayLabel)
        
        pulldown.backgroundColor = UIColor.clearColor()
        pulldown.frame = CGRectMake(bounds.size.width - pulldownWidth, 0, pulldownWidth, bounds.size.height)
        addSubview(pulldown)
        
        layer.masksToBounds = true
        layer.cornerRadius = 4.5
    }
    
    func doClickSelectView() {
        dataSource?.clickSelectView(pulldownData, viewObject: self)
    }

}
