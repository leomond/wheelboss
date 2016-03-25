//
//  RightView.swift
//  WheelBossDesign
//
//  Created by 李秋声 on 16/2/9.
//  Copyright © 2016年 Leomond. All rights reserved.
//

import UIKit

class RightView: UIView {

    var identifier: String = "myOrder" {didSet {setNeedsDisplay()}}
    
    var lastIdentifier: String = ""
    
    var myOrderView: MyOrderView = MyOrderView()
    
    var takeAndUploadView: TakeAndUploadView = TakeAndUploadView()
    
    var myInfo: MyInfoView = MyInfoView()
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        if identifier != "" && lastIdentifier != "" && identifier != lastIdentifier {
            switch lastIdentifier {
            case "myOrder":
                myOrderView.removeFromSuperview()
                break
            case "takeAndUpload":
                takeAndUploadView.removeFromSuperview()
                break
            case "myInfo":
                myInfo.removeFromSuperview()
                break
            default: break
            }
        }
        switch identifier {
        case "myOrder":
            myOrderView.frame = CGRectMake(0, 0, bounds.size.width, bounds.size.height)
            myOrderView.backgroundColor = UIColor.clearColor()
            addSubview(myOrderView)
            break
        case "takeAndUpload":
            takeAndUploadView.frame = CGRectMake(0, 0, bounds.size.width, bounds.size.height)
            takeAndUploadView.backgroundColor = UIColor.clearColor()
            addSubview(takeAndUploadView)
            break
        case "myInfo":
            myInfo.frame = CGRectMake(0, 0, bounds.size.width, bounds.size.height)
            myInfo.backgroundColor = UIColor.clearColor()
            addSubview(myInfo)
            break
        default: break
        }
        lastIdentifier = identifier
    }

}
