//
//  LogisticsInfoDetailView.swift
//  WheelBossDesign
//
//  Created by 李秋声 on 16/2/24.
//  Copyright © 2016年 Leomond. All rights reserved.
//

import UIKit

class LogisticsInfoDetailView: UIView {

    var logisticsCompany = UILabel()
    var logisticsCompanyValue = UILabel()
    var wayBillId = UILabel()
    var wayBillIdValue = UILabel()
    var address = UILabel()
    var addressValue = UILabel()
    
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
        logisticsCompany.text = "物流公司："
        logisticsCompany.frame = CGRectMake(0, space, labelWidth, height)
        addSubview(logisticsCompany)
        
        logisticsCompanyValue.frame = CGRectMake(labelWidth, space, width, height)
        logisticsCompanyValue.textColor = UIColor(red: 153 / 255, green: 153 / 255, blue: 153 / 255, alpha: 1)
        addSubview(logisticsCompanyValue)
        
        wayBillId.text = "运单号："
        wayBillId.textAlignment = .Right
        wayBillId.frame = CGRectMake(bounds.size.width / 2, space, labelWidth, height)
        addSubview(wayBillId)
        
        wayBillIdValue.frame = CGRectMake(bounds.size.width / 2 + labelWidth, space, width, height)
        wayBillIdValue.textColor = UIColor(red: 153 / 255, green: 153 / 255, blue: 153 / 255, alpha: 1)
        addSubview(wayBillIdValue)
        
        address.text = "收货地址："
        address.frame = CGRectMake(0, height + lineSpace + space, labelWidth, height)
        addSubview(address)
        
        addressValue.frame = CGRectMake(labelWidth, height + lineSpace + space, bounds.size.width - labelWidth, height)
        addressValue.textColor = UIColor(red: 153 / 255, green: 153 / 255, blue: 153 / 255, alpha: 1)
        addSubview(addressValue)
    }

    func getHeight() -> CGFloat {
        return space * 2 + height * 2 + lineSpace
    }

}
