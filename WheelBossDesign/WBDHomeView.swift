//
//  WBDHomeView.swift
//  WheelBossDesign
//
//  Created by 李秋声 on 16/2/18.
//  Copyright © 2016年 Leomond. All rights reserved.
//

import UIKit

class WBDHomeView: UIView {
    
    var titleView: WBDHomeTabView = WBDHomeTabView()
    
    var bodyView = WBDBodyView()
    
    var comingsoonView = ComingSoonView()
    
    var comingsoon: Bool = false {
        didSet {
            updateUI()
            setNeedsDisplay()
        }
    }
    
    var buttomView: UIImageView = UIImageView()
    
    var titleHeightRatio: CGFloat = 0.2
    
    var buttomHeightRatio: CGFloat = 0.1

    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        let titleHeight: CGFloat = bounds.size.height * titleHeightRatio
        titleView.frame = CGRectMake(0, 0, bounds.size.width, titleHeight)
        titleView.backgroundColor = UIColor.clearColor()
        addSubview(titleView)
        
        updateUI()
    }
    
    func updateUI() {
        let titleHeight: CGFloat = bounds.size.height * titleHeightRatio
        if comingsoon {
            bodyView.removeFromSuperview()
            buttomView.removeFromSuperview()
            comingsoonView.frame = CGRectMake(0, titleHeight, bounds.size.width, bounds.size.height * (1 - titleHeightRatio - buttomHeightRatio))
            comingsoonView.backgroundColor = UIColor.clearColor()
            addSubview(comingsoonView)
        } else {
            comingsoonView.removeFromSuperview()
            bodyView.frame = CGRectMake(0, titleHeight, bounds.size.width, bounds.size.height * (1 - titleHeightRatio - buttomHeightRatio))
            bodyView.backgroundColor = UIColor.clearColor()
            addSubview(bodyView)
            
            buttomView.image = UIImage(named: "arrow")
            let defaultMinWidth: CGFloat = bounds.size.width / 6
            buttomView.frame = CGRectMake((bounds.size.width - defaultMinWidth) / 2 , bounds.size.height * (1 - buttomHeightRatio), defaultMinWidth, bounds.size.height * buttomHeightRatio)
            addSubview(buttomView)
        }
    }

}
