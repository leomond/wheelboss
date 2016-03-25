//
//  UploadAvatarView.swift
//  WheelBossDesign
//
//  Created by 李秋声 on 16/3/7.
//  Copyright © 2016年 Leomond. All rights reserved.
//

import UIKit

class UploadAvatarView: UIView {
    
    var avatar = UIImageView()
    
    var upload = UIButton()
    
//    var label: UILabel = UILabel() {didSet {setNeedsDisplay()}}
    var spaceRatio: CGFloat = 0.1
    
    var buttonHeight: CGFloat = 44

    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        layer.borderColor = UIColor.grayColor().CGColor
        layer.borderWidth = 1
        upload.setTitle("上传门店照片", forState: .Normal)
        upload.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        upload.backgroundColor = UIColor.grayColor()
        
        let avatarWidth = bounds.size.width * (1 - spaceRatio * 2)
//        avatar.image = UIImage(named: "default-store")
        avatar.frame = CGRectMake(bounds.size.width * spaceRatio, bounds.size.width * spaceRatio, avatarWidth, avatarWidth)
        avatar.layer.masksToBounds = true
        avatar.layer.cornerRadius = avatarWidth / 2
        addSubview(avatar)
        
        upload.frame = CGRectMake(0, bounds.size.height - buttonHeight, bounds.size.width, buttonHeight)
        addSubview(upload)
        
//        label.text = "敬请期待"
//        label.textAlignment = .Center
//        label.textColor = UIColor.grayColor()
//        label.frame = CGRectMake((bounds.size.width - 100) / 2, (bounds.size.height - 44) / 2, 100, 44)
//        addSubview(label)

    }

}
