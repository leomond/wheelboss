//
//  OrderDetailScrollView.swift
//  WheelBossDesign
//
//  Created by 李秋声 on 16/2/23.
//  Copyright © 2016年 Leomond. All rights reserved.
//

import UIKit

class OrderDetailScrollView: UIScrollView {
    
    var orderInfo = OrderTitleView()
    var orderInfoView = OrderDetailView()
    var orderInfoModule = OrderModuleView()
    
    var carInfo = OrderTitleView()
    var carInfoView = CarInfoDetailView()
    var carInfoModule = OrderModuleView()
    
    var productInfo = OrderTitleView()
    var productInfoView = ProductInfoDetailView()
    var productInfoModule = OrderModuleView()
    
    var custInfo = OrderTitleView()
    var custInfoView = CustInfoDetailView()
    var custInfoModule = OrderModuleView()
    
    var logisticsInfo = OrderTitleView()
    var logisticsInfoView = LogisticsInfoDetailView()
    var logisticsInfoModule = OrderModuleView()
    
    var topSpace: CGFloat = 20
    
    var moduleSpace: CGFloat = 13
    
    var buttonSpace: CGFloat = 40
    
    var showLogistics: Bool = true {didSet {setNeedsDisplay()}}

    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        orderInfo.title = "订单信息"
        orderInfo.titleIcon = "orderinfo"
        orderInfoModule.titleView = orderInfo
        orderInfoModule.bodyView = orderInfoView
        let orderInfoModuleHeight = orderInfoModule.titleHeight + orderInfoView.getHeight()
        orderInfoModule.frame = CGRectMake(0, topSpace, bounds.size.width, orderInfoModuleHeight)
        orderInfoModule.backgroundColor = UIColor.whiteColor()
        addSubview(orderInfoModule)
        
        carInfo.title = "车辆信息"
        carInfo.titleIcon = "carinfo"
        carInfoModule.titleView = carInfo
        carInfoModule.bodyView = carInfoView
        let carInfoModuleHeight: CGFloat = carInfoModule.titleHeight + carInfoView.getHeight()
        carInfoModule.frame = CGRectMake(0, topSpace + orderInfoModuleHeight + moduleSpace, bounds.size.width, carInfoModuleHeight)
        carInfoModule.backgroundColor = UIColor.whiteColor()
        addSubview(carInfoModule)
        
        productInfo.title = "商品信息"
        productInfo.titleIcon = "productinfo"
        productInfoModule.titleView = productInfo
        productInfoModule.bodyView = productInfoView
        let productInfoModuleHeight: CGFloat = productInfoModule.titleHeight + productInfoView.getHeight()
        productInfoModule.frame = CGRectMake(0, topSpace + orderInfoModuleHeight + carInfoModuleHeight + moduleSpace * 2, bounds.size.width, productInfoModuleHeight)
        productInfoModule.backgroundColor = UIColor.whiteColor()
        addSubview(productInfoModule)
        
        custInfo.title = "客户信息"
        custInfo.titleIcon = "custinfo"
        custInfoModule.titleView = custInfo
        custInfoModule.bodyView = custInfoView
        let custInfoModuleHeight: CGFloat = custInfoModule.titleHeight + custInfoView.getHeight()
        custInfoModule.frame = CGRectMake(0, topSpace + orderInfoModuleHeight + carInfoModuleHeight + moduleSpace * 3 + productInfoModuleHeight, bounds.size.width, custInfoModuleHeight)
        custInfoModule.backgroundColor = UIColor.whiteColor()
        addSubview(custInfoModule)
        
        if showLogistics {
            logisticsInfo.title = "物流信息"
            logisticsInfo.titleIcon = "logisticsInfo"
            logisticsInfoModule.titleView = logisticsInfo
            logisticsInfoModule.bodyView = logisticsInfoView
            let logisticsInfoModuleHeight: CGFloat = logisticsInfoModule.titleHeight + logisticsInfoView.getHeight()
            logisticsInfoModule.frame = CGRectMake(0, topSpace + orderInfoModuleHeight + carInfoModuleHeight + moduleSpace * 4 + productInfoModuleHeight + custInfoModuleHeight, bounds.size.width, logisticsInfoModuleHeight)
            logisticsInfoModule.backgroundColor = UIColor.whiteColor()
            addSubview(logisticsInfoModule)
        } else {
            logisticsInfoModule.removeFromSuperview()
        }
        
    }

}
