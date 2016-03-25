//
//  MineLeftListCellView.swift
//  WheelBossDesign
//
//  Created by 李秋声 on 16/2/8.
//  Copyright © 2016年 Leomond. All rights reserved.
//

import UIKit

protocol MineLeftListCellDataSource: class {
    func onClickListCell(identifier: String)
}

class MineLeftListCellView: UIView {
    
    var icon: UIImageView = UIImageView()
    
    var label: UILabel = UILabel()
    
    var background: UIImageView = UIImageView()
    
    var title: String = ""
    
    var imageNamed: String = ""
    
    var selected: Bool = false {didSet {setNeedsDisplay()}}
    
    var iconHeight: CGFloat = 24
    
    var labelRatio: CGFloat = 0.62
    
    var iconLabelSpace: CGFloat = 10
    
    var backgroundImageName: String = "mine-left-selected"
    
    var identifier: String = ""
    
    weak var dataSource: MineLeftListCellDataSource?

    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        
        // set selected background
        if selected {
            background.frame = CGRectMake(0, 0, bounds.size.width, bounds.size.height)
            background.image = UIImage(named: backgroundImageName)
            addSubview(background)
        } else {
            background.removeFromSuperview()
        }
        
        let iconX: CGFloat = bounds.size.width * (1 - labelRatio) - iconHeight - iconLabelSpace
        icon.image = UIImage(named: imageNamed)
        icon.frame = CGRectMake(iconX, (bounds.size.height - iconHeight) / 2, iconHeight, iconHeight)
        addSubview(icon)
        
        label.text = title
        label.frame = CGRectMake(bounds.size.width * (1 - labelRatio), 0, bounds.size.width * labelRatio, bounds.size.height)
        label.textColor = UIColor.blackColor()
        label.font = UIFont.systemFontOfSize(18)
        addSubview(label)
        
//        let linePath = UIBezierPath()
//        linePath.moveToPoint(CGPoint(x: 0, y: bounds.size.height))
//        linePath.addLineToPoint(CGPoint(x: bounds.size.width, y: bounds.size.height))
//        let dash: [CGFloat] = [1, 1]
//        linePath.setLineDash(dash, count: 2, phase: 0)
//        UIColor.grayColor().set()
//        linePath.stroke()
    }
    
    func clickMenu(gesture: UITapGestureRecognizer) {
        if identifier != "" {
            dataSource?.onClickListCell(identifier)
        }
    }

}
