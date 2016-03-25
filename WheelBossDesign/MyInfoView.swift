//
//  MyInfoView.swift
//  WheelBossDesign
//
//  Created by 李秋声 on 16/2/9.
//  Copyright © 2016年 Leomond. All rights reserved.
//

import UIKit

class MyInfoView: UIView, MyInfoHeaderViewDataSource {

//    var label: UILabel = UILabel() {didSet {setNeedsDisplay()}}
    var titleView = MyInfoHeaderView()
    
    var myBaseInfo = MyBaseInfoBodyView()
    
    var pwdModify = PasswordManageView()
    
    var titleViewHeight: CGFloat = 50 {didSet {setNeedsDisplay()}}
    
    var space: CGFloat = 10 {didSet {setNeedsDisplay()}}
    
    var currentBodyView: String = "" {
        didSet{
            currentBodyView = titleView.focusButton
            setNeedsDisplay()
        }
    }
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
//        label.text = "敬请期待"
//        label.frame = CGRectMake((bounds.size.width - 100) / 2, (bounds.size.height - 44) / 2, 100, 44)
//        addSubview(label)
        if titleView.frame.origin == CGPointZero {
            titleView.dataSource = self
        }
        titleView.frame = CGRectMake(space, space, bounds.size.width - space * 2, titleViewHeight)
        titleView.backgroundColor = UIColor.whiteColor()
        addSubview(titleView)
        let y = space * 2 + titleViewHeight
        let height = bounds.size.height - space * 3 - titleViewHeight
        let width = bounds.size.width - space * 2
        if currentBodyView == "密码管理" {
            myBaseInfo.removeFromSuperview()
            pwdModify.frame = CGRectMake(space, y, width, height)
            pwdModify.backgroundColor = UIColor.whiteColor()
            addSubview(pwdModify)
        } else {
            pwdModify.removeFromSuperview()
            myBaseInfo.frame = CGRectMake(space, y, width, height)
            myBaseInfo.backgroundColor = UIColor.whiteColor()
            addSubview(myBaseInfo)
        }
    }
    
    func clickMyInfoHeadState(state: String) {
        currentBodyView = state
    }

}
