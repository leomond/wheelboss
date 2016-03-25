//
//  WBDScrollView.swift
//  WheelBossDesign
//
//  Created by 李秋声 on 16/2/14.
//  Copyright © 2016年 Leomond. All rights reserved.
//

import UIKit

protocol WBDBodyViewDataSource: class {
    func designWheelBoss(wheelInfo: WheelBossInfo)
}

class WBDBodyView: UIView, WBDHubViewDataSource {
    
    var labelFontSize: CGFloat = 40
    
    var minScale: CGFloat = 0.6
    
    var spaceRadio: CGFloat = 0.1
    
    var views: Dictionary<Int, WBDHubView> = Dictionary<Int, WBDHubView>()
    
    var wheelList: [WheelBossInfo] = [WheelBossInfo]() {
        didSet {
            for (_, value) in views {
                value.removeFromSuperview()
            }
            views = Dictionary<Int, WBDHubView>()
            setNeedsDisplay()
        }
    }
    
    var defaultMinWidth: CGFloat = 0
    
    weak var dataSource: WBDBodyViewDataSource?
    
    var scale: CGFloat = 0 {didSet {setNeedsDisplay()}}

    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        defaultMinWidth = bounds.size.width / 6
        if wheelList.count == 0 {
            return
        }
        let defaultCenterX: [CGFloat] = getDefaultCenterX(defaultMinWidth, count: wheelList.count)
        let order = getViewsInfo(defaultCenterX,count: wheelList.count)
        for (key, value) in views {
            var removed: Bool = true
            for view in order {
                if view.wheelInfo.index == key {
                    removed = false
                    break
                }
            }
            if removed {
                value.removeFromSuperview()
            }
        }
        for view in order {
            views[view.wheelInfo.index] = view
            addSubview(view)
        }
    }
    
    func getViewsInfo(defaultCenterX: [CGFloat],count: Int) -> [WBDHubView] {
        var result: [WBDHubView] = [WBDHubView]()
        var orderList: [Int] = [Int]()
        var movedSpace: CGFloat = scale
        switch count {
        case 1:
            orderList = [0]
            movedSpace = 0
            break
        case 2:
            orderList = [1, 0]
            break
        case 3:
            orderList = [1, 2, 0]
            break
        case 4:
            orderList = [2, 1, 3, 0]
            break
        default:
            orderList = [2, count - 2, 1, count - 1, 0]
            while movedSpace >= defaultMinWidth / 2 {
                movedSpace -= defaultMinWidth
                let tmp = orderList
                orderList[3] = tmp[1]
                orderList[4] = tmp[3]
                orderList[2] = tmp[4]
                orderList[0] = tmp[2]
                orderList[1] = tmp[1] - 1
                while orderList[1] < 0 {
                    orderList[1] += count
                }
            }
            while movedSpace < 0 - defaultMinWidth / 2 {
                movedSpace += defaultMinWidth
                let tmp = orderList
                orderList[1] = tmp[3]
                orderList[3] = tmp[4]
                orderList[4] = tmp[2]
                orderList[2] = tmp[0]
                orderList[0] = tmp[0] + 1
                while orderList[0] > count - 1 {
                    orderList[0] -= count
                }
            }
            break
        }
        for var index: Int = 0; index < orderList.count; index++ {
            let centerX: CGFloat = defaultCenterX[index] + movedSpace
            let width: CGFloat = getWidth(centerX, minWidth: defaultMinWidth)
            let x: CGFloat = centerX - width / 2
            let y: CGFloat = bounds.size.height * spaceRadio / getScale(centerX)
            let view: WBDHubView = views[orderList[index]] ?? WBDHubView()
            if view.frame.origin == CGPointZero {
                view.addGestureRecognizer(UITapGestureRecognizer(target: view, action: "clickForDesign"))
                view.dataSource = self
            }
            view.frame = CGRectMake(x, y, width, bounds.size.height - 2 * y)
            view.backgroundColor = UIColor.clearColor()
            view.fontSize = labelFontSize * getScale(centerX)
            var viewInfo: WheelBossInfo = wheelList[orderList[index]]
            viewInfo.index = orderList[index]
            view.wheelInfo = viewInfo
            if index == orderList.count - 1 {
                view.focusedView = true
            } else {
                view.focusedView = false
            }
            result += [view]
        }
        return result
    }
    
    func getDefaultCenterX(defaultMinWidth: CGFloat, count: Int) -> [CGFloat] {
        switch count {
        case 1:
            return [defaultMinWidth * 3]
        case 2:
            return [defaultMinWidth * 4, defaultMinWidth * 3]
        case 3:
            return [defaultMinWidth * 4, defaultMinWidth * 2, defaultMinWidth * 3]
        case 4:
            return [defaultMinWidth * 5, defaultMinWidth * 4, defaultMinWidth * 2, defaultMinWidth * 3]
        case 5:
            fallthrough
        default:
            return [defaultMinWidth * 5, defaultMinWidth, defaultMinWidth * 4, defaultMinWidth * 2, defaultMinWidth * 3]
        }
    }
    
    func getScale(centerX: CGFloat) -> CGFloat {
        let x: CGFloat = bounds.size.width / 2
        return (1 - abs(centerX - x) / x) * (1 - minScale) + minScale
    }
    
    func getWidth(centerX: CGFloat, minWidth: CGFloat) -> CGFloat {
        return minWidth * getScale(centerX) / minScale
    }
    
    func panned(gesture: UIPanGestureRecognizer) {
        let translaction = gesture.translationInView(self)
        switch gesture.state {
        case .Ended:
            var tmp = scale
            while tmp >= defaultMinWidth / 2 {
                tmp -= defaultMinWidth
            }
            while tmp < 0 - defaultMinWidth / 2 {
                tmp += defaultMinWidth
            }
            scale -= tmp
            break
        case .Changed:
            scale += translaction.x
            gesture.setTranslation(CGPointZero, inView: self)
            break
        default:
            break
        }
    }
    
    func doClickForDesign(wheelInfo: WheelBossInfo, focused: Bool) {
        if focused {
            dataSource?.designWheelBoss(wheelInfo)
        } else {
            let view = views[wheelInfo.index]
            let count: Int = Int(((view?.frame.origin.x)! + (view?.bounds.size.width)! / 2) / defaultMinWidth)
            let totalSpace: CGFloat = CGFloat(3 - count) * defaultMinWidth
            let spaces: [CGFloat] = splitToArray(totalSpace)
            for value in spaces  {
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) { () -> Void in
                    for var i = 0; i < 300000; i++ {}
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.scale += value
                    })
                }
            }
        }
    }
    
    private func splitToArray(totalSpace: CGFloat) -> [CGFloat] {
        var array: [CGFloat] = [CGFloat]()
        var temp: CGFloat = abs(totalSpace)
        while temp > 8 {
            let random: CGFloat = CGFloat(arc4random_uniform(3) + 5)
            array += [random]
            temp -= random
        }
        array += [temp]
        if totalSpace < 0 {
            var _array: [CGFloat] = [CGFloat]()
            for step in array {
                _array += [0 - step]
            }
            array = _array
        }
        return array
    }

}
