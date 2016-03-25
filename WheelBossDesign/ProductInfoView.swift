//
//  ProductInfoView.swift
//  WheelBossDesign
//
//  Created by 李秋声 on 16/2/16.
//  Copyright © 2016年 Leomond. All rights reserved.
//

import UIKit

class ProductInfoView: UIView {
    
    var wheelType = UILabel()
    var wheelTypeValue = UILabel() {didSet {setNeedsDisplay()}}
    var productionTechnology = UILabel()
    var productionTechnologyValue = SelectView()
    
//    var testImage = UIImageView()
    
    func draw1stLine() {
//        testImage.frame = CGRectMake(0, 0, 100, 100)
//        addSubview(testImage)
        wheelType.text = "轮毂类型："
        
        wheelTypeValue.textColor = OrderConfirmInfo.DefalutOrderInfoValueTextColor
        
        productionTechnology.text = "生产工艺："
        
        productionTechnologyValue.backgroundColor = UIColor.groupTableViewBackgroundColor()
        productionTechnologyValue.placeholder = "请选择工艺"
        drawTopLine(wheelType, firstLabelValue: wheelTypeValue, secondLabel: productionTechnology, secondLabelValue: productionTechnologyValue, lineNumber: 0)
    }
    
    var wheelModel = UILabel()
    var wheelModelValue = UILabel()
    var centerCover = UILabel()
    var centerCoverValue = SelectView()
    
    func draw2ndLine() {
        wheelModel.text = "轮毂型号："
        
        wheelModelValue.textColor = OrderConfirmInfo.DefalutOrderInfoValueTextColor
        
        centerCover.text = "中心盖："
        
        centerCoverValue.backgroundColor = UIColor.groupTableViewBackgroundColor()
        centerCoverValue.placeholder = "请选择中心盖"
        centerCoverValue.pulldownData = ["CGCG盖", "原车盖"]
        
        drawTopLine(wheelModel, firstLabelValue: wheelModelValue, secondLabel: centerCover, secondLabelValue: centerCoverValue, lineNumber: 1)
    }
    
    var wheelColor = UILabel()
    var wheelColorValue = WheelColorValue()
//    var wheelColorForLw = WheelColorValueView()
//    var wheelColorForly = WheelColorValueView()
//    var wheelColorForLf = WheelColorValueView()
    var tirePressureHole = UILabel()
    var tirePressureHoleValue = SelectView()
    var brakeDisc = UILabel()
    var brakeDIscValue = SelectView()
    
    func draw3rdLine() {
        wheelColor.text = "轮毂颜色："
        
//        wheelColorForLw.backgroundColor = UIColor.clearColor()
//        wheelColorForLw.wheelType.text = "轮辋 — "
//        wheelColorForLw.wheelType.textColor = OrderConfirmInfo.DefalutOrderInfoValueTextColor
//        wheelColorForLw.colorValue.textColor = OrderConfirmInfo.DefalutOrderInfoValueTextColor
//        wheelColorForly.backgroundColor = UIColor.clearColor()
//        wheelColorForly.wheelType.text = "轮缘 — "
//        wheelColorForly.wheelType.textColor = OrderConfirmInfo.DefalutOrderInfoValueTextColor
//        wheelColorForly.colorValue.textColor = OrderConfirmInfo.DefalutOrderInfoValueTextColor
//        wheelColorForLf.backgroundColor = UIColor.clearColor()
//        wheelColorForLf.wheelType.text = "轮辐 — "
//        wheelColorForLf.wheelType.textColor = OrderConfirmInfo.DefalutOrderInfoValueTextColor
//        wheelColorForLf.colorValue.textColor = OrderConfirmInfo.DefalutOrderInfoValueTextColor
        wheelColorValue.backgroundColor = UIColor.clearColor()
        
        tirePressureHole.text = "胎压孔："
        
        tirePressureHoleValue.placeholder = "请选择胎压孔"
        tirePressureHoleValue.backgroundColor = UIColor.groupTableViewBackgroundColor()
        tirePressureHoleValue.pulldownData = ["是", "否"]
        
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
        tirePressureHole.frame = CGRectMake(bounds.size.width - valueWidth - labelWidth, y, labelWidth, height)
        addSubview(tirePressureHole)
        
        tirePressureHoleValue.frame = CGRectMake(bounds.size.width - valueWidth, y, valueWidth, height)
        addSubview(tirePressureHoleValue)
        
//        drawTopLine(wheelColor, firstLabelValue: wheelColorForLw, secondLabel: tirePressureHole, secondLabelValue: tirePressureHoleValue, lineNumber: 2)
//        let y1 = space + lineSpace * 2 + height * 3
//        wheelColorForly.frame = CGRectMake(labelWidth, y1, valueWidth, height)
//        addSubview(wheelColorForly)
//        
//        let y2 = space + lineSpace * 2 + height * 4
//        wheelColorForLf.frame = CGRectMake(labelWidth, y2, valueWidth, height)
//        addSubview(wheelColorForLf)
        
        let y1 = space + (height + lineSpace) * 3
        brakeDisc.text = "刹车盘："
        brakeDisc.textAlignment = .Right
        brakeDisc.textColor = UIColor(red: 16 / 255, green: 17 / 255, blue: 19 / 255, alpha: 1)
        brakeDisc.frame = CGRectMake(bounds.size.width - valueWidth - labelWidth, y1, labelWidth, height)
        addSubview(brakeDisc)
        
        brakeDIscValue.placeholder = "请选择刹车盘"
        brakeDIscValue.backgroundColor = UIColor.groupTableViewBackgroundColor()
        brakeDIscValue.pulldownData = ["未修改", "修改过"]
        brakeDIscValue.frame = CGRectMake(bounds.size.width - valueWidth, y1, valueWidth, height)
        addSubview(brakeDIscValue)
        
    }
    
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
    var frontCountValue = StepperView()
    var rearCount = UILabel()
    var rearCountValue = StepperView()
    
    func drawWheelCount() {
        frontCount.text = "前轮数量："
        
        frontCountValue.backgroundColor = UIColor.groupTableViewBackgroundColor()
        frontCountValue.input.keyboardType = .NumberPad
        frontCountValue.input.text = "2"
        frontCountValue.maxIntValue = 2
        
        rearCount.text = "后轮数量："
        
        rearCountValue.backgroundColor = UIColor.groupTableViewBackgroundColor()
        rearCountValue.input.keyboardType = .NumberPad
        rearCountValue.input.text = "2"
        rearCountValue.maxIntValue = 2
        
        drawWheelCount(frontCount, firstLabelValue: frontCountValue, fistTips: UILabel(), secondLabel: rearCount, secondLabelValue: rearCountValue, secondTips: UILabel(), lineNumber: 0)
    }
    
    var frontSize = LabelView()
    var frontSizeValue = StepperView()
    var rearSize = LabelView()
    var rearSizeValue = StepperView()
    
    func drawWheelSize() {
        frontSize.text = "尺寸"
        
        frontSizeValue.backgroundColor = UIColor.groupTableViewBackgroundColor()
        frontSizeValue.input.keyboardType = .NumberPad
        frontSizeValue.maxIntValue = 99
        
        rearSize.text = "尺寸"
        
        rearSizeValue.backgroundColor = UIColor.groupTableViewBackgroundColor()
        rearSizeValue.input.keyboardType = .NumberPad
        rearSizeValue.maxIntValue = 99
        
        drawButtomLine(frontSize, firstLabelValue: frontSizeValue, fistTips: UILabel(), secondLabel: rearSize, secondLabelValue: rearSizeValue, secondTips: UILabel(), lineNumber: 1)
    }
    
    var frontWidth = LabelView()
    var frontWidthValue = StepperView()
    var rearWidth = LabelView()
    var rearWidthValue = StepperView()
    
    func drawWheelWidth() {
        frontWidth.text = "宽度"
        
        frontWidthValue.backgroundColor = UIColor.groupTableViewBackgroundColor()
        frontWidthValue.input.keyboardType = .DecimalPad
        frontWidthValue.step = 0.5
        
        rearWidth.text = "宽度"
        
        rearWidthValue.backgroundColor = UIColor.groupTableViewBackgroundColor()
        rearWidthValue.input.keyboardType = .DecimalPad
        rearWidthValue.step = 0.5
        
        drawButtomLine(frontWidth, firstLabelValue: frontWidthValue, fistTips: UILabel(), secondLabel: rearWidth, secondLabelValue: rearWidthValue, secondTips: UILabel(), lineNumber: 2)
    }
    
    var frontPcd = LabelView()
    var frontPcdValue = PcdView()
    var frontPcdTips = UILabel()
    var rearPcd = LabelView()
    var rearPcdValue = PcdView()
    var rearPcdTips = UILabel()
    
    func drawWheelPcd() {
        frontPcd.text = "孔距\n(PCD)"
        
        frontPcdValue.backgroundColor = UIColor.clearColor()
        
        frontPcdTips.text = "（填写范围100~300）"
        
        rearPcd.text = "孔距\n(PCD)"
        
        rearPcdValue.backgroundColor = UIColor.clearColor()
        
        rearPcdTips.text = "（填写范围100~300）"
        
        drawButtomLine(frontPcd, firstLabelValue: frontPcdValue, fistTips: frontPcdTips, secondLabel: rearPcd, secondLabelValue: rearPcdValue, secondTips: rearPcdTips, lineNumber: 3)
    }
    
    var frontCbd = LabelView()
    var frontCbdValue = TextFieldView()
    var frontCbdTips = UILabel()
    var rearCbd = LabelView()
    var rearCbdValue = TextFieldView()
    var rearCbdTips = UILabel()
    
    func drawWheelCbd() {
        frontCbd.text = "中心孔\n(CBD)"
        
        frontCbdValue.backgroundColor = UIColor.groupTableViewBackgroundColor()
        frontCbdValue.input.keyboardType = .DecimalPad
        
        frontCbdTips.text = "（填写范围54.1~74.2）"
        
        rearCbd.text = "中心孔\n(CBD)"
        
        rearCbdValue.backgroundColor = UIColor.groupTableViewBackgroundColor()
        rearCbdValue.input.keyboardType = .DecimalPad
        
        rearCbdTips.text = "（填写范围54.1~74.2）"
        
        drawButtomLine(frontCbd, firstLabelValue: frontCbdValue, fistTips: frontCbdTips, secondLabel: rearCbd, secondLabelValue: rearCbdValue, secondTips: rearCbdTips, lineNumber: 4)
    }
    
    var frontEt = LabelView()
    var frontEtValue = TextFieldView()
    var frontEtTips = UILabel()
    var rearEt = LabelView()
    var rearEtValue = TextFieldView()
    var rearEtTips = UILabel()
    
    func drawWheelEt() {
        frontEt.text = "偏距\n(ET)"
        
        frontEtValue.backgroundColor = UIColor.groupTableViewBackgroundColor()
        frontEtValue.input.keyboardType = .DecimalPad
        
        frontEtTips.text = "（填写范围15~45）"
        
        rearEt.text = "偏距\n(ET)"
        
        rearEtValue.backgroundColor = UIColor.groupTableViewBackgroundColor()
        rearEtValue.input.keyboardType = .DecimalPad
        
        rearEtTips.text = "（填写范围15~45）"
        
        drawButtomLine(frontEt, firstLabelValue: frontEtValue, fistTips: frontEtTips, secondLabel: rearEt, secondLabelValue: rearEtValue, secondTips: rearEtTips, lineNumber: 5)
    }
    
    var height: CGFloat = 44
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
        drawSplit()
        drawWheelCount()
        drawWheelSize()
        drawWheelWidth()
        drawWheelPcd()
        drawWheelCbd()
        drawWheelEt()
    }
    
    func drawTopLine(firstLabel: UILabel, firstLabelValue: UIView, secondLabel: UILabel, secondLabelValue: UIView, lineNumber: Int) {
        let y = space + (height + lineSpace) * CGFloat(lineNumber)
        firstLabel.textAlignment = .Right
        firstLabel.textColor = UIColor(red: 16 / 255, green: 17 / 255, blue: 19 / 255, alpha: 1)
        firstLabel.frame = CGRectMake(0, y, labelWidth, height)
        addSubview(firstLabel)
        
        firstLabelValue.frame = CGRectMake(labelWidth, y, valueWidth, height)
        addSubview(firstLabelValue)
        
        secondLabel.textAlignment = .Right
        secondLabel.textColor = UIColor(red: 16 / 255, green: 17 / 255, blue: 19 / 255, alpha: 1)
        secondLabel.frame = CGRectMake(bounds.size.width - valueWidth - labelWidth, y, labelWidth, height)
        addSubview(secondLabel)
        
        secondLabelValue.frame = CGRectMake(bounds.size.width - valueWidth, y, valueWidth, height)
        addSubview(secondLabelValue)
    }
    
    func drawWheelCount(firstLabel: UILabel, firstLabelValue: UIView, fistTips: UILabel, secondLabel: UILabel, secondLabelValue: UIView, secondTips: UILabel, lineNumber: Int) {
        let y = space + lineSpace * 3 + height * 5 + lineWidth + spaceLine + (height + lineSpace) * CGFloat(lineNumber)
        
        firstLabel.frame = CGRectMake(0, y, labelWidth, height)
        addSubview(firstLabel)
        
        firstLabelValue.frame = CGRectMake(labelWidth, y, valueWidth / 2, height)
        addSubview(firstLabelValue)
        
        if fistTips.text != "" {
            fistTips.textColor = UIColor(red: 153 / 255, green: 153 / 255, blue: 153 / 255, alpha: 1)
            fistTips.font = UIFont(name: "ArialMT", size: 12)
            fistTips.frame = CGRectMake(labelWidth + valueWidth / 2, y, valueWidth / 2, height)
            addSubview(fistTips)
        }
        
        secondLabel.frame = CGRectMake(bounds.size.width - valueWidth - labelWidth, y, labelWidth, height)
        addSubview(secondLabel)
        
        secondLabelValue.frame = CGRectMake(bounds.size.width - valueWidth, y, valueWidth / 2, height)
        addSubview(secondLabelValue)
        
        if secondTips.text != "" {
            secondTips.textColor = UIColor(red: 153 / 255, green: 153 / 255, blue: 153 / 255, alpha: 1)
            secondTips.font = UIFont(name: "ArialMT", size: 12)
            secondTips.frame = CGRectMake(bounds.size.width - valueWidth / 2, y, valueWidth / 2, height)
            addSubview(secondTips)
        }
    }
    
    func drawButtomLine(firstLabel: LabelView, firstLabelValue: UIView, fistTips: UILabel, secondLabel: LabelView, secondLabelValue: UIView, secondTips: UILabel, lineNumber: Int) {
        let y = space + lineSpace * 3 + height * 5 + lineWidth + spaceLine + (height + lineSpace) * CGFloat(lineNumber)
        
        firstLabel.frame = CGRectMake(0, y, labelWidth, height)
        firstLabel.backgroundColor = UIColor.clearColor()
        addSubview(firstLabel)
        
        firstLabelValue.frame = CGRectMake(labelWidth, y, valueWidth / 2, height)
        addSubview(firstLabelValue)
        
        if fistTips.text != "" {
            fistTips.textColor = UIColor(red: 153 / 255, green: 153 / 255, blue: 153 / 255, alpha: 1)
            fistTips.font = UIFont(name: "ArialMT", size: 12)
            fistTips.frame = CGRectMake(labelWidth + valueWidth / 2, y, valueWidth / 2, height)
            addSubview(fistTips)
        }
        
        secondLabel.frame = CGRectMake(bounds.size.width - valueWidth - labelWidth, y, labelWidth, height)
        secondLabel.backgroundColor = UIColor.clearColor()
        addSubview(secondLabel)
        
        secondLabelValue.frame = CGRectMake(bounds.size.width - valueWidth, y, valueWidth / 2, height)
        addSubview(secondLabelValue)
        
        if secondTips.text != "" {
            secondTips.textColor = UIColor(red: 153 / 255, green: 153 / 255, blue: 153 / 255, alpha: 1)
            secondTips.font = UIFont(name: "ArialMT", size: 12)
            secondTips.frame = CGRectMake(bounds.size.width - valueWidth / 2, y, valueWidth / 2, height)
            addSubview(secondTips)
        }
    }

}
