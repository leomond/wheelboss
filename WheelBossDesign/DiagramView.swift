//
//  DiagramView.swift
//  WheelBossDesign
//
//  Created by 李秋声 on 16/2/7.
//  Copyright © 2016年 Leomond. All rights reserved.
//

import UIKit

class DiagramView: UIView {
    
    var seriesName: UILabel = UILabel() {didSet {setNeedsDisplay()}}
    
    var modelName: UILabel = UILabel() {didSet {setNeedsDisplay()}}
    
    var previewView: PreviewView = PreviewView() {didSet {setNeedsDisplay()}}
    
    var leftSpace: CGFloat = 30
    
    var topSpace: CGFloat = 40
    
    var seriesNameHeight: CGFloat = 44
    
    var modelNameHeight: CGFloat = 30
    
    var buttomSpace: CGFloat = 20
    
    var maxSide: CGFloat = 480
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        var previewSideLength = min(bounds.size.height - topSpace - seriesNameHeight - modelNameHeight - buttomSpace, bounds.size.width - leftSpace * 2)
        previewSideLength = min(maxSide, previewSideLength)
        leftSpace = (bounds.size.width - previewSideLength) / 2
        seriesName.frame = CGRectMake(leftSpace, topSpace, bounds.size.width - leftSpace * 2, seriesNameHeight)
        seriesName.font = UIFont(name: "ArialMT", size: 24)
        seriesName.textColor = UIColor(red: 200/225, green: 35/225, blue: 42/225, alpha: 1)
        addSubview(seriesName)
        
        modelName.frame = CGRectMake(leftSpace, topSpace + seriesNameHeight, bounds.size.width - leftSpace * 2, modelNameHeight)
        modelName.font = UIFont(name: "ArialMT", size: 18)
        modelName.textColor = UIColor(red: 153/225, green: 153/225, blue: 153/225, alpha: 1)
        addSubview(modelName)
        
        
        previewView.frame = CGRectMake(leftSpace, topSpace + seriesNameHeight + modelNameHeight, previewSideLength, previewSideLength)
        previewView.backgroundColor = UIColor.clearColor()
        addSubview(previewView)
    }
    

}
