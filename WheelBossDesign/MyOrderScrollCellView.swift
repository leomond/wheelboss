//
//  MyOrderScrollCellView.swift
//  WheelBossDesign
//
//  Created by 李秋声 on 16/2/14.
//  Copyright © 2016年 Leomond. All rights reserved.
//

import UIKit

protocol MyOrderScrollCellViewDataSource: class {
    func moreOrderInfo(orderInfo: MyOrderInfoCell)
    
    func orderNoticeAction(orderInfo: MyOrderInfoCell)
}

class MyOrderScrollCellView: UIView {
    
    weak var dataSource: MyOrderScrollCellViewDataSource?

    var orderInfo: MyOrderInfoCell = MyOrderInfoCell() {didSet {setNeedsDisplay()}}
    
    var spaceX: CGFloat = 20
    
    var labelHeight: CGFloat = 36
    
//    var orderNumberName: UILabel = UILabel()
//    var orderNumberNameWidth: CGFloat = 80
//    
//    var orderNumberValue: UILabel = UILabel()
//    var orderNumberValueWidth: CGFloat = 300
    
    var orderTimeName: UILabel = UILabel()
    var orderTimeNameWidth: CGFloat = 80
    
    var orderTimeValue: UILabel = UILabel()
    var orderTimeValueWidth: CGFloat = 170
    
    var moreIcon: UILabel = UILabel()
    var moreIconWidth: CGFloat = 20
    
    var lineSplitWidth: CGFloat = 1
    
    var pictureView = UIImageView()
    var pictureSpaceLine: CGFloat = 10
    var pictureSideLength: CGFloat = 120
    
    var productSeries: UILabel = UILabel()
    var productSeriesWidth: CGFloat = 120
    
    var productModel: UILabel = UILabel()
    var productModelWidth: CGFloat = 120
    
    var productInfoLabelHeight: CGFloat = 40
    
    var custInfoName: UILabel = UILabel()
    var custInfoNameWidth: CGFloat = 80
    
    var custInfoValue: UILabel = UILabel()
    var custInfoValueWidth: CGFloat = 300
    
    var phoneName: UILabel = UILabel()
    var phoneNameWidth: CGFloat = 80
    
    var phoneValue: UILabel = UILabel()
    var phoneValueWidth: CGFloat = 120
    
    var orderStateName: UILabel = UILabel()
    var orderStateNameWidth: CGFloat = 80
    
    var orderStateValue: UILabel = UILabel()
    var orderStateValueWidth: CGFloat = 60
    
    var orderStateButton: UIButton = UIButton(type: UIButtonType.Custom)
    var buttonHeigth: CGFloat = 36
    
    var rightSpace: CGFloat = 60
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // 1st line
        draw1stLine()
        
        // split line
        drawSplitLine()
        
        // pictrue
        drawPicture()
        
        // body center
        drawBodyCenter()
        
        // state
        drawState()
        
    }
    
    func drawState() {
        orderStateName.text = "订单状态："
        orderStateValue.text = orderInfo.orderState
        let fistLineY: CGFloat = labelHeight + lineSplitWidth + pictureSpaceLine + productInfoLabelHeight
        let valueX: CGFloat = bounds.size.width - rightSpace - orderStateValueWidth
        orderStateValue.frame = CGRectMake(valueX, fistLineY, orderStateValueWidth, labelHeight)
        orderStateValue.font = UIFont.systemFontOfSize(16)
        orderStateValue.textColor = UIColor.grayColor()
        addSubview(orderStateValue)
        
        let nameX: CGFloat = valueX - orderStateNameWidth
        orderStateName.frame = CGRectMake(nameX, fistLineY, orderStateNameWidth, labelHeight)
        orderStateName.font = UIFont.systemFontOfSize(16)
        orderStateName.textColor = UIColor.grayColor()
        addSubview(orderStateName)
        
        let title = getTitle(orderInfo.orderState)
        
        if title == "" {
            orderStateButton.removeFromSuperview()
            return
        }
        
        let secondLineY: CGFloat = fistLineY + labelHeight
        let buttonWidth: CGFloat = 130
        if orderStateButton.frame.origin.x == 0 {
            orderStateButton.addTarget(self, action: "noticeAction:", forControlEvents: UIControlEvents.TouchUpInside)
        }
        orderStateButton.frame = CGRectMake(nameX, secondLineY, buttonWidth, buttonHeigth)
//        orderStateButton.setBackgroundImage(UIImage(named: "mine-product-notice"), forState: .Normal)
        orderStateButton.setTitleColor(UIColor(red: 200 / 255, green: 35 / 255, blue: 42 / 255, alpha: 1), forState: UIControlState.Normal)
        orderStateButton.setTitle(title, forState: UIControlState.Normal)
        orderStateButton.titleLabel?.font = UIFont.systemFontOfSize(16)
        orderStateButton.layer.borderColor = UIColor(red: 200 / 255, green: 35 / 255, blue: 42 / 255, alpha: 1).CGColor
        orderStateButton.layer.borderWidth = 0.8
        orderStateButton.layer.cornerRadius = 4.5
        
        addSubview(orderStateButton)
    }
    
    func getTitle(state: String) -> String {
        switch state {
        case "待确认":
            return "取消订单"
        case "待收货":
            return "确认收货"
        case "待安装":
            return "安装完成"
        default:
            return ""
        }
    }
    
    func drawBodyCenter() {
        productSeries.text = orderInfo.productSeries
        productModel.text = orderInfo.productModel
        let x: CGFloat = spaceX * 2 + pictureSideLength
        let fistLineY: CGFloat = labelHeight + lineSplitWidth + pictureSpaceLine
        productSeries.frame = CGRectMake(x, fistLineY, productSeriesWidth, productInfoLabelHeight)
        productSeries.font = UIFont.systemFontOfSize(20)
        productSeries.textColor = UIColor.blackColor()
        addSubview(productSeries)
        
        productModel.frame = CGRectMake(x + productSeriesWidth, fistLineY, productModelWidth, productInfoLabelHeight)
        productModel.font = UIFont.systemFontOfSize(20)
        productModel.textColor = UIColor.blackColor()
        addSubview(productModel)
        
        custInfoName.text = "客户信息："
        custInfoValue.text = orderInfo.custInfo
        let secondLineY: CGFloat = fistLineY + productInfoLabelHeight
        custInfoName.frame = CGRectMake(x, secondLineY, custInfoNameWidth, labelHeight)
        custInfoName.font = UIFont.systemFontOfSize(16)
        custInfoName.textColor = UIColor.grayColor()
        addSubview(custInfoName)
        
        custInfoValue.frame = CGRectMake(x + custInfoNameWidth, secondLineY, custInfoValueWidth, labelHeight)
        custInfoValue.font = UIFont.systemFontOfSize(16)
        custInfoValue.textColor = UIColor.grayColor()
        addSubview(custInfoValue)
        
        phoneName.text = "联系电话："
        phoneValue.text = orderInfo.phone
        
        let thirdLineY: CGFloat = secondLineY + labelHeight
        phoneName.frame = CGRectMake(x, thirdLineY, phoneNameWidth, labelHeight)
        phoneName.font = UIFont.systemFontOfSize(16)
        phoneName.textColor = UIColor.grayColor()
        addSubview(phoneName)
        
        phoneValue.frame = CGRectMake(x + phoneNameWidth, thirdLineY, phoneValueWidth, labelHeight)
        phoneValue.font = UIFont.systemFontOfSize(16)
        phoneValue.textColor = UIColor.grayColor()
        addSubview(phoneValue)
    }
    
    func drawPicture() {
        pictureView.frame = CGRectMake(spaceX, labelHeight + lineSplitWidth + pictureSpaceLine, pictureSideLength, pictureSideLength)
//        pictureView.lw = UIImageView(image: UIImage(named: orderInfo.productPicture.lw))
//        pictureView.lf = UIImageView(image: UIImage(named: orderInfo.productPicture.lf))
//        pictureView.ly = UIImageView(image: UIImage(named: orderInfo.productPicture.ly))
        if orderInfo.wheelpic != "" {
            let imgURL:NSURL=NSURL(string: orderInfo.wheelpic)!
            let request:NSURLRequest=NSURLRequest(URL:imgURL)
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(),
                completionHandler: {(response, data, error)->Void in
                    if data != nil {
                        let img=UIImage(data:data!)
                        self.pictureView.image = img
                    }
            })
        }
        
        pictureView.backgroundColor = UIColor.clearColor()
        addSubview(pictureView)
    }
    
    func drawSplitLine() {
        let line = UIBezierPath()
        line.moveToPoint(CGPoint(x: spaceX / 2, y: labelHeight))
        line.addLineToPoint(CGPoint(x: bounds.size.width - spaceX / 2, y: labelHeight))
        UIColor(red: 153 / 255, green: 153 / 255, blue: 153 / 255, alpha: 0.3).set()
        line.stroke()
    }
    
    func draw1stLine() {
//        orderNumberName.text = "订单编号："
//        orderNumberValue.text = orderInfo.orderNumber
        orderTimeName.text = "下单时间："
        orderTimeValue.text = orderInfo.orderTime
        moreIcon.text = "›"
//        orderNumberName.frame = CGRectMake(spaceX, 0, orderNumberNameWidth, labelHeight)
//        orderNumberName.font = UIFont(name: "ArialMT", size: 16)
//        orderNumberName.textColor = UIColor.grayColor()
//        addSubview(orderNumberName)
//        
//        orderNumberValue.frame = CGRectMake(spaceX + orderNumberNameWidth, 0, orderNumberValueWidth, labelHeight)
//        orderNumberValue.font = UIFont(name: "ArialMT", size: 16)
//        orderNumberValue.textColor = UIColor.grayColor()
//        addSubview(orderNumberValue)
        
        orderTimeName.frame = CGRectMake(spaceX, 0, orderTimeNameWidth, labelHeight)
        orderTimeName.font = UIFont.systemFontOfSize(16)
        orderTimeName.textColor = UIColor.grayColor()
        addSubview(orderTimeName)
        
        orderTimeValue.frame = CGRectMake(spaceX + orderTimeNameWidth, 0, orderTimeValueWidth, labelHeight)
        orderTimeValue.font = UIFont.systemFontOfSize(16)
        orderTimeValue.textColor = UIColor.grayColor()
        addSubview(orderTimeValue)
        
        moreIcon.frame = CGRectMake(bounds.size.width - spaceX / 2 - moreIconWidth, 0, moreIconWidth, labelHeight)
        moreIcon.font = UIFont.systemFontOfSize(24)
        moreIcon.textColor = UIColor(red: 153 / 255, green: 153 / 255, blue: 153 / 255, alpha: 0.6)
        addSubview(moreIcon)
        
//        orderTimeValue.frame = CGRectMake(bounds.size.width - spaceX / 2 - moreIconWidth - orderTimeValueWidth, 0, orderTimeValueWidth, labelHeight)
//        orderTimeValue.font = UIFont(name: "ArialMT", size: 16)
//        orderTimeValue.textColor = UIColor.grayColor()
//        addSubview(orderTimeValue)
//        
//        orderTimeName.frame = CGRectMake(bounds.size.width - spaceX / 2 - moreIconWidth - orderTimeValueWidth - orderTimeNameWidth, 0, orderTimeNameWidth, labelHeight)
//        orderTimeName.font = UIFont(name: "ArialMT", size: 16)
//        orderTimeName.textColor = UIColor.grayColor()
//        addSubview(orderTimeName)
    }
    
    func noticeAction(button: UIButton) {
//        print("notice")
        dataSource?.orderNoticeAction(orderInfo)
    }
    
    func queryDetail(gesture: UITapGestureRecognizer) {
//        print("more info")
        dataSource?.moreOrderInfo(orderInfo)
    }

}
