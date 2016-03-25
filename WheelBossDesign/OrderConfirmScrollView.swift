//
//  OrderConfirmScrollView.swift
//  WheelBossDesign
//
//  Created by 李秋声 on 16/2/16.
//  Copyright © 2016年 Leomond. All rights reserved.
//

import UIKit

class OrderConfirmScrollView: UIScrollView {
    
    var carInfo = OrderTitleView()
    var carInfoView: CarInfoView = CarInfoView()
    
    var productInfo = OrderTitleView()
    var productInfoView: ProductInfoView = ProductInfoView()
    
    var custInfo = OrderTitleView()
    var custInfoView: CustInfoView = CustInfoView()
    
    var topSpace: CGFloat = 20
    
    var moduleSpace: CGFloat = 13
    
    var buttonSpace: CGFloat = 40
    
    var carInfoModule = OrderModuleView()
    
    var productInfoModule = OrderModuleView()
    
    var custInfoModule = OrderModuleView()

    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing car info
        carInfo.title = "车辆信息"
        carInfo.titleIcon = "carinfo"
        carInfoModule.titleView = carInfo
        carInfoModule.bodyView = carInfoView
        let carInfoModuleHeight: CGFloat = carInfoModule.titleHeight + carInfoView.space * 2 + carInfoView.height * 3 + carInfoView.lineSpace * 2
        carInfoModule.frame = CGRectMake(0, topSpace, bounds.size.width, carInfoModuleHeight)
        carInfoModule.backgroundColor = UIColor.whiteColor()
        addSubview(carInfoModule)
        
        // drawing productInfo
        productInfo.title = "商品信息"
        productInfo.titleIcon = "productinfo"
        productInfoModule.titleView = productInfo
        productInfoModule.bodyView = productInfoView
        let productInfoModuleHeight: CGFloat = productInfoModule.titleHeight + productInfoView.space * 2 + productInfoView.lineSpace * 8 + productInfoView.height * 11 + productInfoView.lineWidth + productInfoView.spaceLine
        productInfoModule.frame = CGRectMake(0, topSpace + carInfoModuleHeight + moduleSpace, bounds.size.width, productInfoModuleHeight)
        productInfoModule.backgroundColor = UIColor.whiteColor()
        addSubview(productInfoModule)
        
        custInfo.title = "客户信息"
        custInfo.titleIcon = "custinfo"
        custInfoModule.titleView = custInfo
        custInfoModule.bodyView = custInfoView
        let custInfoModuleHeight: CGFloat = custInfoModule.titleHeight + custInfoView.space * 2 + custInfoView.height * 3 + custInfoView.lineSpace
        custInfoModule.frame = CGRectMake(0, topSpace + carInfoModuleHeight + moduleSpace * 2 + productInfoModuleHeight, bounds.size.width, custInfoModuleHeight)
        custInfoModule.backgroundColor = UIColor.whiteColor()
        addSubview(custInfoModule)
    }

}
