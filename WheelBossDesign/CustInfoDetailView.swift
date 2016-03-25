//
//  CustInfoDetailView.swift
//  WheelBossDesign
//
//  Created by 李秋声 on 16/2/24.
//  Copyright © 2016年 Leomond. All rights reserved.
//

import UIKit

class CustInfoDetailView: UIView {

    var custName = UILabel()
    var custNameValue = UILabel()
    var phone = UILabel()
    var phoneValue = UILabel()
    var custMsg = UILabel()
    var custMsgValue = UITextView()
    
    var lineSpace: CGFloat = 13
    var labelWidth: CGFloat = 86
    var contentRatio: CGFloat = 0.9
    
    var space: CGFloat = 26
    
    var height: CGFloat = 36
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        let width: CGFloat = (bounds.size.width / 2 - labelWidth) * contentRatio
        custName.text = "客户姓名："
        custName.frame = CGRectMake(0, space, labelWidth, height)
        addSubview(custName)
        
        custNameValue.frame = CGRectMake(labelWidth, space, width, height)
        custNameValue.textColor = UIColor(red: 153 / 255, green: 153 / 255, blue: 153 / 255, alpha: 1)
        addSubview(custNameValue)
        
        phone.text = "联系电话："
        phone.frame = CGRectMake(bounds.size.width / 2, space, labelWidth, height)
        addSubview(phone)
        
        phoneValue.frame = CGRectMake(bounds.size.width / 2 + labelWidth, space, width, height)
        phoneValue.textColor = UIColor(red: 153 / 255, green: 153 / 255, blue: 153 / 255, alpha: 1)
        addSubview(phoneValue)
        
        custMsg.text = "客户留言："
        custMsg.frame = CGRectMake(0, height + lineSpace + space, labelWidth, height)
        addSubview(custMsg)
        
        custMsgValue.frame = CGRectMake(labelWidth, height + lineSpace + space, bounds.size.width - labelWidth, height * 2)
        custMsgValue.backgroundColor = UIColor.clearColor()
        custMsgValue.editable = false
        custMsgValue.textColor = UIColor(red: 153 / 255, green: 153 / 255, blue: 153 / 255, alpha: 1)
        custMsgValue.font = UIFont.systemFontOfSize(16)
        addSubview(custMsgValue)
    }

    func getHeight() -> CGFloat {
        return space * 2 + height * 3 + lineSpace
    }

}
