//
//  LoginComponentUIView.swift
//  design
//
//  Created by 李秋声 on 16/1/26.
//  Copyright © 2016年 Leomond. All rights reserved.
//

import UIKit

class LoginComponentUIView: UIView {
    
    var textField: UITextField = UITextField() {didSet {setNeedsDisplay()}}
    
    var lineWidth: CGFloat = 1 {didSet {setNeedsDisplay()}}
    
    var placeholder: String = "Text Field" {didSet {setNeedsDisplay()}}
    
    var secureTextEntry: Bool = false {didSet {setNeedsDisplay()}}
    
    var minimumFontSize: CGFloat = 17 {didSet {setNeedsDisplay()}}
    
    var adjustsFontSizeToFitWidth: Bool = true {didSet {setNeedsDisplay()}}
    
    var color: UIColor = UIColor.whiteColor() {didSet {setNeedsDisplay()}}
    
    var fontSize: CGFloat = 20 {didSet {setNeedsDisplay()}}
    
    var fontName: String = "ArialMT" {didSet {setNeedsDisplay()}}
    
    var lineColor: UIColor = UIColor.whiteColor() {didSet {setNeedsDisplay()}}
    
    var marginLeft: CGFloat = 2 {didSet {setNeedsDisplay()}}
    
    var placeholderColor: UIColor = UIColor.groupTableViewBackgroundColor() {didSet {setNeedsDisplay()}}
    
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        textField.frame = CGRectMake(marginLeft, 0, bounds.size.width - marginLeft, bounds.size.height - lineWidth)
        textField.borderStyle = UITextBorderStyle.None
        textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSForegroundColorAttributeName: placeholderColor])
        textField.adjustsFontSizeToFitWidth = adjustsFontSizeToFitWidth
        textField.minimumFontSize = minimumFontSize
        textField.borderStyle = .None
        textField.clearButtonMode = UITextFieldViewMode.WhileEditing
        textField.textColor = color
        textField.font = UIFont(name: fontName, size: fontSize)
        textField.secureTextEntry = secureTextEntry
        textField.returnKeyType = .Next
        if secureTextEntry {
            textField.clearsOnBeginEditing = true
            textField.returnKeyType = .Go
        }
        textField.keyboardType = .ASCIICapable
        textField.autocorrectionType = .No // 自动纠错
        textField.autocapitalizationType = .None // 首字母大写
        addSubview(textField)
        
        let linePath = UIBezierPath()
        linePath.moveToPoint(CGPoint(x: 0, y: bounds.size.height - lineWidth))
        linePath.addLineToPoint(CGPoint(x: bounds.size.width,y: bounds.size.height - lineWidth))
        linePath.lineWidth = lineWidth
        lineColor.set()
        linePath.stroke()
    }

}
