//
//  ProductInfoDetailView.swift
//  WheelBossDesign
//
//  Created by 李秋声 on 16/2/24.
//  Copyright © 2016年 Leomond. All rights reserved.
//

import UIKit

class ProductInfoDetailView: UIView {
    
    var wheelType = UILabel()
    var wheelTypeValue = UILabel() {didSet {setNeedsDisplay()}}
    var productionTechnology = UILabel()
    var productionTechnologyValue = UILabel()
    
    func draw1stLine() {
        wheelType.text = "轮毂类型："
        
        wheelTypeValue.textColor = UIColor(red: 153 / 255, green: 153 / 255, blue: 153 / 255, alpha: 1)
        
        productionTechnology.text = "生产工艺："
        
        productionTechnologyValue.textColor = UIColor(red: 153 / 255, green: 153 / 255, blue: 153 / 255, alpha: 1)
        
        drawTopLine(wheelType, firstLabelValue: wheelTypeValue, secondLabel: productionTechnology, secondLabelValue: productionTechnologyValue, lineNumber: 0)
    }
    
    var wheelModel = UILabel()
    var wheelModelValue = UILabel()
    var centerCover = UILabel()
    var centerCoverValue = UILabel()
    
    func draw2ndLine() {
        wheelModel.text = "轮毂型号："
        
        wheelModelValue.textColor = UIColor(red: 153 / 255, green: 153 / 255, blue: 153 / 255, alpha: 1)
        
        centerCover.text = "中心盖："
        
        centerCoverValue.textColor = UIColor(red: 153 / 255, green: 153 / 255, blue: 153 / 255, alpha: 1)
        
        drawTopLine(wheelModel, firstLabelValue: wheelModelValue, secondLabel: centerCover, secondLabelValue: centerCoverValue, lineNumber: 1)
    }
    
    var wheelColor = UILabel()
    var wheelColorValue = WheelColorValue()
//    var wheelColorForLw = WheelColorValueView()
//    var wheelColorForly = WheelColorValueView()
//    var wheelColorForLf = WheelColorValueView()
    var tirePressureHole = UILabel()
    var tirePressureHoleValue = UILabel()
    var brakeDisc = UILabel()
    var brakeDiscValue = UILabel()
    
    func draw3rdLine() {
        wheelColor.text = "轮毂颜色："
        
        let color = UIColor(red: 153 / 255, green: 153 / 255, blue: 153 / 255, alpha: 1)
        wheelColorValue.display.textColor = color
        wheelColorValue.backgroundColor = UIColor.clearColor()
        
//        wheelColorForLw.wheelType.textColor = color
//        wheelColorForLw.colorValue.textColor = color
//        wheelColorForly.wheelType.textColor = color
//        wheelColorForly.colorValue.textColor = color
//        wheelColorForLf.wheelType.textColor = color
//        wheelColorForLf.colorValue.textColor = color
//        
//        wheelColorForLw.backgroundColor = UIColor.clearColor()
//        wheelColorForLw.wheelType.text = "轮辋 — "
        
        tirePressureHole.text = "胎压孔："
        
        tirePressureHoleValue.textColor = UIColor(red: 153 / 255, green: 153 / 255, blue: 153 / 255, alpha: 1)
//        drawTopLine(wheelColor, firstLabelValue: wheelColorForLw, secondLabel: tirePressureHole, secondLabelValue: tirePressureHoleValue, lineNumber: 2)
//        let y1 = space + lineSpace * 2 + height * 3
//        wheelColorForly.frame = CGRectMake(labelWidth, y1, valueWidth, height)
//        wheelColorForly.backgroundColor = UIColor.clearColor()
//        wheelColorForly.wheelType.text = "轮缘 — "
//        addSubview(wheelColorForly)
//        
//        let y2 = space + lineSpace * 2 + height * 4
//        wheelColorForLf.frame = CGRectMake(labelWidth, y2, valueWidth, height)
//        wheelColorForLf.backgroundColor = UIColor.clearColor()
//        wheelColorForLf.wheelType.text = "轮辐 — "
//        addSubview(wheelColorForLf)
        let y = space + (height + lineSpace) * 2
        wheelColor.textAlignment = .Right
        wheelColor.textColor = UIColor(red: 16 / 255, green: 17 / 255, blue: 19 / 255, alpha: 1)
        wheelColor.frame = CGRectMake(0, y, labelWidth, height)
        addSubview(wheelColor)
        
        let wheelColorValueHeight = height * 3
        wheelColorValue.frame = CGRectMake(labelWidth, y, valueWidth, wheelColorValueHeight)
        addSubview(wheelColorValue)
        
        tirePressureHole.textAlignment = .Right
        tirePressureHole.textColor = UIColor(red: 16 / 255, green: 17 / 255, blue: 19 / 255, alpha: 1)
        tirePressureHole.frame = CGRectMake(bounds.size.width / 2, y, labelWidth, height)
        addSubview(tirePressureHole)
        
        tirePressureHoleValue.frame = CGRectMake(bounds.size.width / 2 + labelWidth, y, valueWidth, height)
        addSubview(tirePressureHoleValue)
        
        let y1 = space + (height + lineSpace) * CGFloat(3)
        brakeDisc.text = "刹车盘："
        brakeDisc.textAlignment = .Right
        brakeDisc.textColor = UIColor(red: 16 / 255, green: 17 / 255, blue: 19 / 255, alpha: 1)
        brakeDisc.frame = CGRectMake(bounds.size.width / 2, y1, labelWidth, height)
        addSubview(brakeDisc)
        
        brakeDiscValue.frame = CGRectMake(bounds.size.width / 2 + labelWidth, y1, valueWidth, height)
        brakeDiscValue.textColor = UIColor(red: 153 / 255, green: 153 / 255, blue: 153 / 255, alpha: 1)
        addSubview(brakeDiscValue)
    }
    
//    var wheelImage = PreviewView()
//    
//    var wheelImageSide: CGFloat = 150
//    
//    func drawWheelImage() {
//        wheelImage.backgroundColor = UIColor.clearColor()
//        wheelImage.frame = CGRectMake(bounds.size.width - wheelImageSide, space, wheelImageSide, wheelImageSide)
//        addSubview(wheelImage)
//    }
    
    func drawSplit() {
        let y = space + lineSpace * 3 + height * 5
        let path = UIBezierPath()
        path.moveToPoint(CGPoint(x: 0, y: y))
        path.addLineToPoint(CGPoint(x: bounds.size.width, y: y))
        let dash: [CGFloat] = [1.0, 1.0]
        path.setLineDash(dash, count: 2, phase: 0)
        path.lineWidth = lineWidth
        UIColor.grayColor().set()
        path.stroke()
    }
    
    var frontCount = UILabel()
    var frontCountValue = UILabel()
    var rearCount = UILabel()
    var rearCountValue = UILabel()
    
    func drawWheelCount() {
        frontCount.text = "前轮数量："
        
        frontCountValue.textColor = UIColor(red: 153 / 255, green: 153 / 255, blue: 153 / 255, alpha: 1)
        
        rearCount.text = "后轮数量："
        
        rearCountValue.textColor = UIColor(red: 153 / 255, green: 153 / 255, blue: 153 / 255, alpha: 1)
        
        drawWheelCount(frontCount, firstLabelValue: frontCountValue, secondLabel: rearCount, secondLabelValue: rearCountValue, lineNumber: 0)
    }
    
    var frontSize = LabelView()
    var frontSizeValue = UILabel()
    var rearSize = LabelView()
    var rearSizeValue = UILabel()
    
    func drawWheelSize() {
        frontSize.text = "尺寸"
        
        frontSizeValue.textColor = UIColor(red: 153 / 255, green: 153 / 255, blue: 153 / 255, alpha: 1)
        
        rearSize.text = "尺寸"
        
        rearSizeValue.textColor = UIColor(red: 153 / 255, green: 153 / 255, blue: 153 / 255, alpha: 1)
        
        drawButtomLine(frontSize, firstLabelValue: frontSizeValue, secondLabel: rearSize, secondLabelValue: rearSizeValue, lineNumber: 1)
    }
    
    var frontWidth = LabelView()
    var frontWidthValue = UILabel()
    var rearWidth = LabelView()
    var rearWidthValue = UILabel()
    
    func drawWheelWidth() {
        frontWidth.text = "宽度"
        
        frontWidthValue.textColor = UIColor(red: 153 / 255, green: 153 / 255, blue: 153 / 255, alpha: 1)
        
        rearWidth.text = "宽度"
        
        rearWidthValue.textColor = UIColor(red: 153 / 255, green: 153 / 255, blue: 153 / 255, alpha: 1)
        
        drawButtomLine(frontWidth, firstLabelValue: frontWidthValue, secondLabel: rearWidth, secondLabelValue: rearWidthValue, lineNumber: 2)
    }
    
    var frontPcd = LabelView()
    var frontPcdValue = UILabel()
    var rearPcd = LabelView()
    var rearPcdValue = UILabel()
    
    func drawWheelPcd() {
        frontPcd.text = "孔距\n(PCD)"
        
        frontPcdValue.textColor = UIColor(red: 153 / 255, green: 153 / 255, blue: 153 / 255, alpha: 1)
        
        rearPcd.text = "孔距\n(PCD)"
        
        rearPcdValue.textColor = UIColor(red: 153 / 255, green: 153 / 255, blue: 153 / 255, alpha: 1)
        
        drawButtomLine(frontPcd, firstLabelValue: frontPcdValue, secondLabel: rearPcd, secondLabelValue: rearPcdValue, lineNumber: 3)
    }
    
    var frontCbd = LabelView()
    var frontCbdValue = UILabel()
    var rearCbd = LabelView()
    var rearCbdValue = UILabel()
    
    func drawWheelCbd() {
        frontCbd.text = "中心孔\n(CBD)"
        
        frontCbdValue.textColor = UIColor(red: 153 / 255, green: 153 / 255, blue: 153 / 255, alpha: 1)
        
        rearCbd.text = "中心孔\n(CBD)"
        
        rearCbdValue.textColor = UIColor(red: 153 / 255, green: 153 / 255, blue: 153 / 255, alpha: 1)
        
        drawButtomLine(frontCbd, firstLabelValue: frontCbdValue, secondLabel: rearCbd, secondLabelValue: rearCbdValue, lineNumber: 4)
    }
    
    var frontEt = LabelView()
    var frontEtValue = UILabel()
    var rearEt = LabelView()
    var rearEtValue = UILabel()
    
    func drawWheelEt() {
        frontEt.text = "偏距\n(ET)"
        
        frontEtValue.textColor = UIColor(red: 153 / 255, green: 153 / 255, blue: 153 / 255, alpha: 1)
        
        rearEt.text = "偏距\n(ET)"
        
        rearEtValue.textColor = UIColor(red: 153 / 255, green: 153 / 255, blue: 153 / 255, alpha: 1)
        
        drawButtomLine(frontEt, firstLabelValue: frontEtValue, secondLabel: rearEt, secondLabelValue: rearEtValue, lineNumber: 5)
    }
    
    var height: CGFloat = 36
    var lineSpace: CGFloat = 13
    var labelWidth: CGFloat = 86
    var space: CGFloat = 26
    var contentRatio: CGFloat = 0.9
    var lineWidth: CGFloat = 1
    var spaceLine: CGFloat = 22
    
    var valueWidth: CGFloat = 0
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        valueWidth = (bounds.size.width / 2 - labelWidth) * contentRatio
        draw1stLine()
        draw2ndLine()
        draw3rdLine()
//        drawWheelImage()
        drawSplit()
        drawWheelCount()
        drawWheelSize()
        drawWheelWidth()
        drawWheelPcd()
        drawWheelCbd()
        drawWheelEt()
    }
    
    func drawTopLine(firstLabel: UILabel, firstLabelValue: UIView, secondLabel: UILabel, secondLabelValue: UILabel, lineNumber: Int) {
        let y = space + (height + lineSpace) * CGFloat(lineNumber)
        firstLabel.textAlignment = .Right
        firstLabel.textColor = UIColor(red: 16 / 255, green: 17 / 255, blue: 19 / 255, alpha: 1)
        firstLabel.frame = CGRectMake(0, y, labelWidth, height)
        addSubview(firstLabel)
        
        firstLabelValue.frame = CGRectMake(labelWidth, y, valueWidth, height)
        addSubview(firstLabelValue)
        
        secondLabel.textAlignment = .Right
        secondLabel.textColor = UIColor(red: 16 / 255, green: 17 / 255, blue: 19 / 255, alpha: 1)
        secondLabel.frame = CGRectMake(bounds.size.width / 2, y, labelWidth, height)
        addSubview(secondLabel)
        
        secondLabelValue.frame = CGRectMake(bounds.size.width / 2 + labelWidth, y, valueWidth, height)
        addSubview(secondLabelValue)
    }
    
    func drawWheelCount(firstLabel: UILabel, firstLabelValue: UILabel, secondLabel: UILabel, secondLabelValue: UILabel, lineNumber: Int) {
        let y = space + lineSpace * 3 + height * 5 + lineWidth + spaceLine + (height + lineSpace) * CGFloat(lineNumber)
        
        firstLabel.frame = CGRectMake(0, y, labelWidth, height)
        addSubview(firstLabel)
        
        firstLabelValue.frame = CGRectMake(labelWidth, y, valueWidth, height)
        addSubview(firstLabelValue)
        
        secondLabel.frame = CGRectMake(bounds.size.width / 2, y, labelWidth, height)
        addSubview(secondLabel)
        
        secondLabelValue.frame = CGRectMake(bounds.size.width / 2 + labelWidth, y, valueWidth, height)
        addSubview(secondLabelValue)
    }
    
    func drawButtomLine(firstLabel: LabelView, firstLabelValue: UILabel, secondLabel: LabelView, secondLabelValue: UILabel, lineNumber: Int) {
        let y = space + lineSpace * 3 + height * 5 + lineWidth + spaceLine + (height + lineSpace) * CGFloat(lineNumber)
        
        firstLabel.frame = CGRectMake(0, y, labelWidth, height)
        firstLabel.backgroundColor = UIColor.clearColor()
        addSubview(firstLabel)
        
        firstLabelValue.frame = CGRectMake(labelWidth, y, valueWidth, height)
        addSubview(firstLabelValue)
        
        secondLabel.frame = CGRectMake(bounds.size.width / 2, y, labelWidth, height)
        secondLabel.backgroundColor = UIColor.clearColor()
        addSubview(secondLabel)
        
        secondLabelValue.frame = CGRectMake(bounds.size.width / 2 + labelWidth, y, valueWidth, height)
        addSubview(secondLabelValue)
    }
    
    func getHeight() -> CGFloat {
        return space * 2 + lineSpace * 8 + height * 11 + lineWidth + spaceLine
    }

}
