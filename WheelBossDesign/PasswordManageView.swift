//
//  PasswordManageView.swift
//  WheelBossDesign
//
//  Created by 李秋声 on 16/3/6.
//  Copyright © 2016年 Leomond. All rights reserved.
//

import UIKit

class PasswordManageView: UIView {
    
    var originalPwd = UITextField()
    
    var newPwd = UITextField()
    
    var repeatPwd = UITextField()
    
    var confirm = UIButton()
    
    var width: CGFloat = 250
    
    var height: CGFloat = 44
    
    var topSpace: CGFloat = 60
    
    var componemtSpace: CGFloat = 20

    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        let x = (bounds.size.width - width) / 2
        originalPwd.frame = CGRectMake(x, topSpace, width, height)
        originalPwd.placeholder = "原密码"
        setCommonTextField(originalPwd)
        addSubview(originalPwd)
        
        newPwd.frame = CGRectMake(x, topSpace + height + componemtSpace, width, height)
        newPwd.placeholder = "新密码"
        setCommonTextField(newPwd)
        addSubview(newPwd)
        
        repeatPwd.frame = CGRectMake(x, topSpace + (height + componemtSpace) * 2, width, height)
        repeatPwd.placeholder = "重复新密码"
        setCommonTextField(repeatPwd)
        addSubview(repeatPwd)
        
        confirm.frame = CGRectMake(x, topSpace + (height + componemtSpace) * 3, width, height)
        confirm.layer.borderColor = UIColor(red: 200 / 255, green: 35 / 255, blue: 42 / 255, alpha: 1).CGColor
        confirm.layer.borderWidth = 0.8
        confirm.setTitle("确认修改", forState: .Normal)
        confirm.setTitleColor(UIColor(red: 200 / 255, green: 35 / 255, blue: 42 / 255, alpha: 1), forState: .Normal)
        confirm.layer.cornerRadius = 4.5
        addSubview(confirm)
    }
    
    func setCommonTextField(textField: UITextField) {
        textField.layer.borderColor = UIColor(red: 153 / 255, green: 153 / 255, blue: 153 / 255, alpha: 0.6).CGColor
        textField.layer.borderWidth = 1
        textField.leftViewMode = .Always
        let leftView = UIView()
        leftView.backgroundColor = UIColor.clearColor()
        var frame = textField.frame
        frame.size.width = 5
        leftView.frame = frame
        textField.leftView = leftView
        textField.secureTextEntry = true
        textField.layer.cornerRadius = 4.5
    }

}
