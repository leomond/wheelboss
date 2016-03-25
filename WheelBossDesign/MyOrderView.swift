//
//  MyOrderView.swift
//  WheelBossDesign
//
//  Created by 李秋声 on 16/2/9.
//  Copyright © 2016年 Leomond. All rights reserved.
//

import UIKit

class MyOrderView: UIView {
    
    var titleView: MyOrderHeadView = MyOrderHeadView() {didSet {setNeedsDisplay()}}
    
    var bodyView: MyOrderBodyScrollView = MyOrderBodyScrollView() {didSet {setNeedsDisplay()}}
    
    var titleViewHeight: CGFloat = 50 {didSet {setNeedsDisplay()}}
    
    var space: CGFloat = 10 {didSet {setNeedsDisplay()}}
    
    var orderList: [MyOrderInfoCell] = [MyOrderInfoCell]() {didSet {setNeedsDisplay()}}
    
    var orderCellheight: CGFloat = 180 {didSet {setNeedsDisplay()}}
    var orderCellSpace: CGFloat = 10 {
        didSet {
            orderCellSpace = space
            setNeedsDisplay()
        }
    }
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        titleView.frame = CGRectMake(space, space, bounds.size.width - space * 2, titleViewHeight)
        titleView.backgroundColor = UIColor.whiteColor()
        addSubview(titleView)
        let maxHeight: CGFloat = bounds.size.height - space * 2 - titleViewHeight
        bodyView.frame = CGRectMake(space, space * 2 + titleViewHeight, bounds.size.width - space * 2, maxHeight)
        let realHeight: CGFloat = max((orderCellheight + orderCellSpace) * CGFloat(orderList.count),maxHeight)
        bodyView.scrollEnabled = true
        bodyView.contentSize = CGSizeMake(bounds.size.width - space * 2, realHeight)
        bodyView.backgroundColor = UIColor.clearColor()
        bodyView.orderList = orderList
        addSubview(bodyView)
    }

}
