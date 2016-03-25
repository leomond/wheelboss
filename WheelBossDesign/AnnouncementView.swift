//
//  AnnouncementView.swift
//  WheelBossDesign
//
//  Created by 李秋声 on 16/3/12.
//  Copyright © 2016年 Leomond. All rights reserved.
//

import UIKit

class AnnouncementView: UIView {
    
    var background = UIImageView()
    var titleLabel = UILabel()
    var contentView = UITextView()
    var okButton = UIButton()
    
    var paddingRatio: CGFloat = 0.04
    
    var titleHeight: CGFloat = 44
    var buttomHeight: CGFloat = 44
    var buttonHeight: CGFloat = 30
    var buttonWidth: CGFloat = 80

    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        background.frame = CGRectMake(0, 0, bounds.size.width, bounds.size.height)
        background.image = UIImage(named: "announcementbkg")
        addSubview(background)
        
        titleLabel.text = "公告"
        titleLabel.textAlignment = .Center
        titleLabel.font = UIFont.systemFontOfSize(24)
        titleLabel.textColor = UIColor(red: 135 / 255, green: 197 / 255, blue: 233 / 255, alpha: 1)
        titleLabel.frame = CGRectMake(0, 0, bounds.size.width, titleHeight)
        addSubview(titleLabel)
        
        contentView.editable = false
        contentView.frame = CGRectMake(bounds.size.width * paddingRatio, titleHeight, bounds.size.width * (1 - paddingRatio * 2), bounds.size.height - titleHeight - buttomHeight)
        contentView.font = UIFont.systemFontOfSize(18)
        contentView.textColor = UIColor(red: 190 / 255, green: 167 / 255, blue: 130 / 255, alpha: 1)
        addSubview(contentView)
        
//        okButton.setTitle("确定", forState: .Normal)
        okButton.frame = CGRectMake((bounds.size.width - buttonWidth) / 2, bounds.size.height - (buttonHeight + buttomHeight) / 2, buttonWidth, buttonHeight)
        okButton.setBackgroundImage(UIImage(named: "announcementok"), forState: .Normal)
//        okButton.layer.borderWidth = 0.4
//        okButton.layer.borderColor = UIColor(red: 153 / 255, green: 153 / 255, blue: 153 / 255, alpha: 1).CGColor
//        okButton.setTitleColor(UIColor(red: 153 / 255, green: 153 / 255, blue: 153 / 255, alpha: 1), forState: .Normal)
//        okButton.titleLabel?.font = UIFont.systemFontOfSize(14)
//        okButton.layer.cornerRadius = 4.5
//        okButton.layer.masksToBounds = true
        addSubview(okButton)
        
    }

}
