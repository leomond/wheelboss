//
//  MyBaseInfoBodyView.swift
//  WheelBossDesign
//
//  Created by 李秋声 on 16/3/6.
//  Copyright © 2016年 Leomond. All rights reserved.
//

import UIKit

class MyBaseInfoBodyView: UIView {
    
    var storeName = UILabel()
    var storeNameValue = UILabel()
    
    var staffId = UILabel()
    var staffIdValue = UILabel()
    
    var contactPerson = UILabel()
    var contactPersonValue = UILabel()
    
    var phone = UILabel()
    var phoneValue = UILabel()
    
    var email = UILabel()
    var emailvalue = UILabel()
    
    var wechat = UILabel()
    var wechatValue = UILabel()
    
    var storeAddress = UILabel()
    var storeAddressValue = UITextView()
    
    var uploadAvatar = UploadAvatarView()
    
    var labelWidth: CGFloat = 100
    var labelHeight: CGFloat = 36
    
    var uploadAvatarWidth: CGFloat = 200
    
    var topSpace: CGFloat = 60
    
    var bothRatio: CGFloat = 0.1
    
    var sideSpacd: CGFloat = 10
    

    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        let x = bounds.size.width * bothRatio
        let valueWidth = bounds.size.width * (1 - bothRatio * 2) - uploadAvatarWidth - sideSpacd - labelWidth
        storeName.text = "门店名称："
        storeName.textAlignment = .Right
        storeName.frame = CGRectMake(x, topSpace, labelWidth, labelHeight)
        addSubview(storeName)
        
        storeNameValue.frame = CGRectMake(x + labelWidth, topSpace, valueWidth, labelHeight)
        storeNameValue.textColor = UIColor(red: 153 / 255, green: 153 / 255, blue: 153 / 255, alpha: 1)
        addSubview(storeNameValue)
        
        staffId.text = "工        号："
        staffId.textAlignment = .Right
        staffId.frame = CGRectMake(x, topSpace + labelHeight, labelWidth, labelHeight)
        addSubview(staffId)
        
        staffIdValue.frame = CGRectMake(x + labelWidth, topSpace + labelHeight, valueWidth, labelHeight)
        staffIdValue.textColor = UIColor(red: 153 / 255, green: 153 / 255, blue: 153 / 255, alpha: 1)
        addSubview(staffIdValue)
        
        contactPerson.text = "联  系  人："
        contactPerson.textAlignment = .Right
        contactPerson.frame = CGRectMake(x, topSpace + labelHeight * 2, labelWidth, labelHeight)
        addSubview(contactPerson)
        
        contactPersonValue.frame = CGRectMake(x + labelWidth, topSpace + labelHeight * 2, valueWidth, labelHeight)
        contactPersonValue.textColor = UIColor(red: 153 / 255, green: 153 / 255, blue: 153 / 255, alpha: 1)
        addSubview(contactPersonValue)
        
        phone.text = "联系电话："
        phone.textAlignment = .Right
        phone.frame = CGRectMake(x, topSpace + labelHeight * 3, labelWidth, labelHeight)
        addSubview(phone)
        
        phoneValue.frame = CGRectMake(x + labelWidth, topSpace + labelHeight * 3, valueWidth, labelHeight)
        phoneValue.textColor = UIColor(red: 153 / 255, green: 153 / 255, blue: 153 / 255, alpha: 1)
        addSubview(phoneValue)
        
        email.text = "邮        箱："
        email.textAlignment = .Right
        email.frame = CGRectMake(x, topSpace + labelHeight * 4, labelWidth, labelHeight)
        addSubview(email)
        
        emailvalue.frame = CGRectMake(x + labelWidth, topSpace + labelHeight * 4, valueWidth, labelHeight)
        emailvalue.textColor = UIColor(red: 153 / 255, green: 153 / 255, blue: 153 / 255, alpha: 1)
        addSubview(emailvalue)
        
        wechat.text = "微        信："
        wechat.textAlignment = .Right
        wechat.frame = CGRectMake(x, topSpace + labelHeight * 5, labelWidth, labelHeight)
        addSubview(wechat)
        
        wechatValue.frame = CGRectMake(x + labelWidth, topSpace + labelHeight * 5, valueWidth, labelHeight)
        wechatValue.textColor = UIColor(red: 153 / 255, green: 153 / 255, blue: 153 / 255, alpha: 1)
        addSubview(wechatValue)
        
        storeAddress.text = "门店地址："
        storeAddress.textAlignment = .Right
        storeAddress.frame = CGRectMake(x, topSpace + labelHeight * 6, labelWidth, labelHeight)
        addSubview(storeAddress)
        
        storeAddressValue.frame = CGRectMake(x + labelWidth, topSpace + labelHeight * 6, valueWidth, labelHeight * 2)
        storeAddressValue.textColor = UIColor(red: 153 / 255, green: 153 / 255, blue: 153 / 255, alpha: 1)
        storeAddressValue.contentMode = .TopLeft
        storeAddressValue.editable = false
        storeAddressValue.font = UIFont.systemFontOfSize(16)
        storeAddressValue.scrollEnabled = false
        addSubview(storeAddressValue)
        
        uploadAvatar.frame = CGRectMake(bounds.size.width * (1 - bothRatio) - uploadAvatarWidth, topSpace, uploadAvatarWidth, labelHeight * 7)
        uploadAvatar.layer.borderWidth = 0.5
        uploadAvatar.layer.borderColor = UIColor(red: 153 / 255, green: 153 / 255, blue: 153 / 255, alpha: 0.6).CGColor
        uploadAvatar.backgroundColor = UIColor.clearColor()
        addSubview(uploadAvatar)
    }

}
