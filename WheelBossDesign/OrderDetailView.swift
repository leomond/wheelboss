//
//  OrderDetailView.swift
//  WheelBossDesign
//
//  Created by 李秋声 on 16/2/24.
//  Copyright © 2016年 Leomond. All rights reserved.
//

import UIKit

class OrderDetailView: UIView {
    
    var orderId = UILabel()
    var orderIdValue = UILabel() {didSet {setNeedsDisplay()}}
    var orderState = UILabel()
    var orderStateValue = UILabel() {didSet {setNeedsDisplay()}}
    
    var orderTime = UILabel()
    var orderTimeValue = UILabel() {didSet {setNeedsDisplay()}}
    
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
        orderId.text = "订单编号："
        orderId.textColor = UIColor(red: 16 / 255, green: 17 / 255, blue: 19 / 255, alpha: 1)
        orderId.frame = CGRectMake(0, space, labelWidth, height)
        addSubview(orderId)
        
        orderIdValue.frame = CGRectMake(labelWidth, space, width, height)
        orderIdValue.textColor = UIColor(red: 153 / 255, green: 153 / 255, blue: 153 / 255, alpha: 1)
        addSubview(orderIdValue)
        
        orderState.text = "订单状态："
        orderState.textColor = UIColor(red: 16 / 255, green: 17 / 255, blue: 19 / 255, alpha: 1)
        orderState.frame = CGRectMake(bounds.size.width / 2, space, labelWidth, height)
        addSubview(orderState)
        
        orderStateValue.frame = CGRectMake(bounds.size.width / 2 + labelWidth, space, width, height)
        orderStateValue.textColor = UIColor(red: 200 / 255, green: 35 / 255, blue: 42 / 255, alpha: 1)
        addSubview(orderStateValue)
        
        orderTime.text = "下单时间："
        orderTime.textColor = UIColor(red: 16 / 255, green: 17 / 255, blue: 19 / 255, alpha: 1)
        orderTime.frame = CGRectMake(0, space + lineSpace + height, labelWidth, height)
        addSubview(orderTime)
        
        orderTimeValue.frame = CGRectMake(labelWidth, space + lineSpace + height, width, height)
        orderTimeValue.textColor = UIColor(red: 153 / 255, green: 153 / 255, blue: 153 / 255, alpha: 1)
        addSubview(orderTimeValue)
    }
    
    func getHeight() -> CGFloat {
        return space * 2 + height * 2 + lineSpace
    }

}
