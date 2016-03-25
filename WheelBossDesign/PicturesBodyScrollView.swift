//
//  PicturesBodyScrollView.swift
//  WheelBossDesign
//
//  Created by 李秋声 on 16/3/20.
//  Copyright © 2016年 Leomond. All rights reserved.
//

import UIKit

protocol PicturesBodyScrollViewDataSource: class {
    func doViewLarge(pictureInfo: PicturesInfo)
}

class PicturesBodyScrollView: UIScrollView, PicturesBodyCellViewDataSource {
    
    var pictures: [PicturesInfo] = [PicturesInfo]() {
        didSet {
            for (_, view) in views {
                view.removeFromSuperview()
            }
            views = Dictionary<String, PicturesBodyCellView>()
            setNeedsDisplay()
        }
    }
    
    var views: Dictionary<String, PicturesBodyCellView> = Dictionary<String, PicturesBodyCellView>()
    
    var space: CGFloat = 5
    
    var columnCount: Int = 4
    var heightWidthRatio: CGFloat = 0.75
    
    weak var dataSource: PicturesBodyScrollViewDataSource?

    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        let viewWidth: CGFloat = (bounds.size.width - space * CGFloat(columnCount + 1)) / CGFloat(columnCount)
        let viewHeight: CGFloat = viewWidth * heightWidthRatio
        var count: Int = 0
        for picture in pictures {
            let view = views[picture.id] ?? PicturesBodyCellView()
            if view.frame.origin == CGPointZero {
                view.addGestureRecognizer(UITapGestureRecognizer(target: view, action: "viewLarger"))
                view.dataSource = self
            }
            view.info = picture
            let row: Int = count / columnCount
            let column: Int = count % columnCount
            view.frame = CGRectMake(space + viewHeight * CGFloat(row), space + viewWidth * CGFloat(column), viewWidth, viewHeight)
            view.backgroundColor = UIColor.clearColor()
            views[picture.id] = view
            addSubview(view)
            count++
        }
    }
    
    func doViewLarge(pictureInfo: PicturesInfo) {
        dataSource?.doViewLarge(pictureInfo)
    }

}
