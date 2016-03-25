//
//  HomeLeftUIView.swift
//  WheelBossDesign
//
//  Created by 李秋声 on 16/1/29.
//  Copyright © 2016年 Leomond. All rights reserved.
//

import UIKit

protocol HomeLeftDataSource: class {
    func changeRightViewBkg(homeRIght: HomeRightStaff)
    func clickFocusedAction(identifier: String)
}

//@IBDesignable
class HomeLeftUIView: UIView {
    
    private struct Constants {
        static let Rotate360DegreesDuration: CGFloat = 1
        static let HorizonOffsetDegrees: CGFloat = 90
        
        static let WheelBossDesignBkgNamed: String = "home-hub-design"
        static let PicturesBkgNamed: String = "home-pictures"
        static let BuyersShowBkgNamed: String = "home-buyersshow"
        static let ContactUsBkgNamed: String = "home-contactus"
        
        static let WheelBossDesignIdentifier: String = "shouWheelBossDesign"
        static let PicturesIdentifier: String = "showPicturesHome"
        static let BuyersShowIdentifier: String = "showBuyersShowList"
        static let ContactUsIdentifier: String = "showContactUs"
        
        static let Relactionship: Dictionary<String, HomeRightStaff> = [
            CommonConstants.WheelBossDesignTitle: HomeRightStaff(background: WheelBossDesignBkgNamed,identifier: WheelBossDesignIdentifier),
            CommonConstants.PicturesTitle: HomeRightStaff(background: PicturesBkgNamed,identifier: PicturesIdentifier),
            CommonConstants.BuyersShowTitle: HomeRightStaff(background: BuyersShowBkgNamed,identifier: BuyersShowIdentifier),
            CommonConstants.ContactUsTitle: HomeRightStaff(background: ContactUsBkgNamed,identifier: ContactUsIdentifier)
        ]
    }
    
    private let defaults = NSUserDefaults.standardUserDefaults()
    
    var buttonOrder: [String] {
        get { return defaults.objectForKey(CommonConstants.ButtonOrder) as? [String] ?? CommonConstants.DefaultButtonOrder }
        set { defaults.setObject(newValue, forKey: CommonConstants.ButtonOrder) }
    }
    
    weak var dataSource: HomeLeftDataSource?
    
    var centerImage: UIImageView = UIImageView() {didSet {setNeedsDisplay()}}
    
//    @IBInspectable
    var btnheight: CGFloat = 44 {didSet {setNeedsDisplay()}}
    
//    @IBInspectable
    var btnWidth: CGFloat = 120 {didSet {setNeedsDisplay()}}
        
//    @IBInspectable
    var btnsBetweenDegrees: CGFloat = 25 {didSet {setNeedsDisplay()}}
    
    var scale: CGFloat = 0 {didSet {setNeedsDisplay()}}
    
    var buttons: Dictionary<String, UIButton> = Dictionary<String, UIButton>()
    
    var btnRadius: CGFloat = 0
    
    var minDegrees: CGFloat = 0
    
    var maxDegrees: CGFloat = 0
    
    var realFocusIndex: Int = 0
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        
        let sidelength = min(bounds.size.height / 2, bounds.size.width)
        centerImage.frame = CGRectMake(0 - sidelength / 2, (bounds.size.height - sidelength) / 2, sidelength, sidelength)
        centerImage.reDrawCircle(sidelength)
        centerImage.transform = CGAffineTransformMakeRotation(calculateDegrees(scale))
        addSubview(centerImage)
        
        
        btnRadius = sidelength / 2 + (bounds.size.width - sidelength / 2 - btnWidth) / 2
        let buttonCount: Int = buttonOrder.count
        var focusIndex: Int = buttonCount / 2
        if buttonCount % 2 == 0 {
            focusIndex -= 1
        }
        minDegrees = Constants.HorizonOffsetDegrees - btnsBetweenDegrees * CGFloat(focusIndex) - btnsBetweenDegrees / 2
        maxDegrees = Constants.HorizonOffsetDegrees + btnsBetweenDegrees * CGFloat(buttonCount - 1 - focusIndex) + btnsBetweenDegrees / 2
        var calculateScale: CGFloat = scale
        let totalDegrees: CGFloat = CGFloat(btnsBetweenDegrees) * CGFloat(buttonCount)
        while abs(calculateScale) >= totalDegrees {
            if calculateScale < 0 {
                calculateScale += totalDegrees
            }
            if calculateScale > 0 {
                calculateScale -= totalDegrees
            }
        }
        realFocusIndex = calculateFocusIndex(scale)
        
        for var index: Int = 0; index < buttonCount; index++ {
            let offset: Int = index - focusIndex
            var degrees: CGFloat = Constants.HorizonOffsetDegrees + btnsBetweenDegrees * CGFloat(offset) + calculateScale
            if degrees <= minDegrees {
                degrees = maxDegrees - (minDegrees - degrees)
            }
            if degrees >= maxDegrees {
                degrees = minDegrees + (degrees - maxDegrees)
            }
            degrees = calculateDegrees(degrees)
            let btnX: CGFloat = sin(degrees) * btnRadius
            let btnY: CGFloat = bounds.size.height / 2 - cos(degrees) * btnRadius - btnheight / 2
            var changeFocus: Bool = false
            let button: UIButton = buttons[buttonOrder[index]] ?? UIButton(type: UIButtonType.RoundedRect)
            if index == realFocusIndex {
                dataSource?.changeRightViewBkg(Constants.Relactionship[buttonOrder[index]]!)
                changeFocus = true
            }
            if button.bounds.origin.x == 0 {
                button.addTarget(self, action: Selector("tapped:"), forControlEvents: .TouchUpInside)
            }
            button.reDraw(buttonOrder[index],changeFocus: changeFocus)
            button.frame = CGRectMake(btnX, btnY, btnWidth, btnheight)
            buttons[buttonOrder[index]] = button
            addSubview(button)
        }
        
    }
    
    func tapped(button: UIButton) {
        let title: String = button.titleForState(UIControlState.Normal)!
        let index: Int = getIndex(title)
        if index == realFocusIndex {
            dataSource?.clickFocusedAction((Constants.Relactionship[title]?.identifier)!)
            return
        }
        var step: Int = realFocusIndex - index
        if step < 0 {
            step += buttonOrder.count
        }
        let totalDegrees: CGFloat = btnsBetweenDegrees * CGFloat(step)
        let degrees: [CGFloat] = splitToArray(totalDegrees)
        for value in degrees  {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) { () -> Void in
                for var i = 0; i < 1000000; i++ {}
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.scale += value
                })
            }
        }
    }
    
    private func splitToArray(totalDegrees: CGFloat) -> [CGFloat] {
        var array: [CGFloat] = [CGFloat]()
        var temp: CGFloat = totalDegrees
        while temp > 8 {
            let random: CGFloat = CGFloat(arc4random_uniform(3) + 5)
            array += [random]
            temp -= random
        }
        array += [temp]
        return array
    }
    
    private func getIndex(title: String) -> Int {
        for var index: Int = 0; index < buttonOrder.count; index++ {
            if title == buttonOrder[index] {
                return index
            }
        }
        return 0
    }
    
    private func calculateFocusIndex(scale: CGFloat) -> Int {
        var index: Int = Int(1.5 - scale / CGFloat(btnsBetweenDegrees))
        if index < 0 {
            index = index - 1
        }
        while index < 0 {
            index += buttonOrder.count
        }
        return index % buttonOrder.count
    }
    
    private func calculateFocusIndex(index: Int) -> Int {
        if index == -1 {
            return buttonOrder.count - 1
        } else if index == buttonOrder.count {
            return 0
        } else {
            return index
        }
    }
    
    func slip(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .Ended:
            var tmpScale = scale
            let total = btnsBetweenDegrees * CGFloat(buttonOrder.count)
            while tmpScale >= 50 {
                tmpScale -= total
            }
            while tmpScale <= -75 {
                tmpScale += total
            }
            let gap: CGFloat = 25 - 25 * CGFloat(realFocusIndex) - tmpScale
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) { () -> Void in
                for var i = 0; i < 1000000; i++ {}
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.scale += gap
                })
            }
            break
        case .Changed:
            let translation = gesture.translationInView(self)
            let degrees = translation.y
            if degrees != 0 {
                scale += degrees
                gesture.setTranslation(CGPointZero, inView: self)
            }
            break
        default: break
        }
    }
    
    private func calculateDegrees(degrees: CGFloat) -> CGFloat {
        return degrees * CGFloat(M_PI) / 180
    }

}

extension UIButton {
    
    func reDraw(title: String, changeFocus: Bool) {
        setTitle(title, forState: UIControlState.Normal)
        if changeFocus {
            setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        } else {
            setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
        }
        setBackgroundImage(UIImage(named: "button"), forState: UIControlState.Normal)
        titleLabel?.font = UIFont(name: "ArialMT", size: 20)
    }
    
}

extension UIImageView {
    
    func reDrawCircle(sidelength: CGFloat) {
        layer.cornerRadius = sidelength / 2;
        layer.masksToBounds = true;
        bounds.size.width = sidelength
        bounds.size.height = sidelength
    }

}
