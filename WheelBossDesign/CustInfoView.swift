//
//  CustInfoView.swift
//  WheelBossDesign
//
//  Created by 李秋声 on 16/2/16.
//  Copyright © 2016年 Leomond. All rights reserved.
//

import UIKit

class CustInfoView: UIView {
    
    var custName = UILabel()
    var custNameValue = TextFieldView()
    var phone = UILabel()
    var phoneValue = TextFieldView()
    var custMsg = UILabel()
    var custMsgValue = UITextView()
    
    var lineSpace: CGFloat = 13
    var labelWidth: CGFloat = 86
    var contentRatio: CGFloat = 0.9
    
    var space: CGFloat = 26
    
    var height: CGFloat = 44

    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        let width: CGFloat = (bounds.size.width / 2 - labelWidth) * contentRatio
        custName.text = "客户姓名："
        custName.frame = CGRectMake(0, space, labelWidth, height)
        addSubview(custName)
        
        custNameValue.frame = CGRectMake(labelWidth, space, width, height)
        custNameValue.backgroundColor = UIColor.groupTableViewBackgroundColor()
        addSubview(custNameValue)
        
        phone.text = "联系电话："
        phone.frame = CGRectMake(bounds.size.width - width - labelWidth, space, labelWidth, height)
        addSubview(phone)
        
        phoneValue.frame = CGRectMake(bounds.size.width - width, space, width, height)
        phoneValue.backgroundColor = UIColor.groupTableViewBackgroundColor()
        phoneValue.input.keyboardType = .PhonePad
        addSubview(phoneValue)
        
        custMsg.text = "客户留言："
        custMsg.frame = CGRectMake(0, height + lineSpace + space, labelWidth, height)
        addSubview(custMsg)
        
        custMsgValue.frame = CGRectMake(labelWidth, height + lineSpace + space, bounds.size.width - labelWidth, height * 2)
        custMsgValue.backgroundColor = UIColor.groupTableViewBackgroundColor()
        custMsgValue.layer.masksToBounds = true
        custMsgValue.layer.cornerRadius = 4.5
        custMsgValue.font = UIFont.systemFontOfSize(16)
        addSubview(custMsgValue)
    }

}
