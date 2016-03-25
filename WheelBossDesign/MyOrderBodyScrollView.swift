//
//  MyOrderBodyScrollView.swift
//  WheelBossDesign
//
//  Created by 李秋声 on 16/2/14.
//  Copyright © 2016年 Leomond. All rights reserved.
//

import UIKit

protocol MyOrderBodyScrollViewDataSource: class {
    func showMoreOrderInfo(orderInfo: MyOrderInfoCell)
    func doOrderNoticeAction(orderInfo: MyOrderInfoCell)
}

class MyOrderBodyScrollView: UIScrollView, MyOrderScrollCellViewDataSource {
    
    weak var dataSource: MyOrderBodyScrollViewDataSource?
    
    var orderList: [MyOrderInfoCell] = [MyOrderInfoCell]() {
        didSet {
            for (_, value) in cells {
                value.removeFromSuperview()
            }
            cells = Dictionary<String, MyOrderScrollCellView>()
            setNeedsDisplay()
        }
    }
    
    var cells: Dictionary<String, MyOrderScrollCellView> = Dictionary<String, MyOrderScrollCellView>()
    
    var noOrderView: NoOrderView = NoOrderView()
    
    var height: CGFloat = 180
    
    var space: CGFloat = 10
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        if orderList.count == 0 {
            noOrderView.backgroundColor = UIColor.whiteColor()
            let noOrderViewHeight = bounds.size.height - space
            noOrderView.frame = CGRectMake(0, 0, bounds.size.width, noOrderViewHeight)
            addSubview(noOrderView)
            return
        }
        noOrderView.removeFromSuperview()
        var index = 0
        for order in orderList {
            let cell: MyOrderScrollCellView = cells[order.orderNumber] ?? MyOrderScrollCellView()
            cell.orderInfo = order
            cell.frame = CGRectMake(0, (height + space) * CGFloat(index), bounds.size.width, height)
            if cell.frame.origin.x == 0 {
                cell.addGestureRecognizer(UITapGestureRecognizer(target: cell, action: "queryDetail:"))
                cell.dataSource = self
            }
            cell.backgroundColor = UIColor.whiteColor()
            cells[order.orderNumber] = cell
            addSubview(cell)
            index++
        }
        
    }
    
    func moreOrderInfo(orderInfo: MyOrderInfoCell) {
        dataSource?.showMoreOrderInfo(orderInfo)
    }
    
    func orderNoticeAction(orderInfo: MyOrderInfoCell) {
        dataSource?.doOrderNoticeAction(orderInfo)
    }

}
