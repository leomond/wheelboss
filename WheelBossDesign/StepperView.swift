//
//  StepperView.swift
//  WheelBossDesign
//
//  Created by 李秋声 on 16/2/23.
//  Copyright © 2016年 Leomond. All rights reserved.
//

import UIKit

@objc protocol StepperViewDataSource: NSObjectProtocol {
    optional func stepperTextFieldValueChanged(textField: UITextField)
}

class StepperView: UIView {
    
    var decrease = UIButton()
    
    var increase = UIButton()
    
    var input = UITextField()
    
    var step: Float = 0.1
    var maxFloatValue: Float = 100
    var minFloatValue: Float = 0
    
    var maxIntValue: Int = 4
    var minIntValue: Int = 0
    
    weak var dataSource: StepperViewDataSource?

    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        if decrease.frame.origin == CGPointZero {
            decrease.addTarget(self, action: "decreaseInputValue", forControlEvents: UIControlEvents.TouchUpInside)
        }
        decrease.frame = CGRectMake(0, 0, bounds.size.height, bounds.size.height)
        decrease.layer.borderColor = UIColor.groupTableViewBackgroundColor().CGColor
        decrease.layer.borderWidth = 2
        decrease.backgroundColor = UIColor.whiteColor()
        decrease.setTitle("−", forState: UIControlState.Normal)
        decrease.setTitleColor(UIColor.blackColor(), forState: .Normal)
        decrease.titleLabel?.font = UIFont.systemFontOfSize(20)
        addSubview(decrease)
        
        input.frame = CGRectMake(bounds.size.height, 0, bounds.size.width - 2 * bounds.size.height, bounds.size.height)
        input.textAlignment = .Center
        addSubview(input)
        
        if increase.frame.origin == CGPointZero {
            increase.addTarget(self, action: "increaseInputValue", forControlEvents: UIControlEvents.TouchUpInside)
        }
        increase.frame = CGRectMake(bounds.size.width - bounds.size.height, 0, bounds.size.height, bounds.size.height)
        increase.layer.borderColor = UIColor.groupTableViewBackgroundColor().CGColor
        increase.layer.borderWidth = 2
        increase.backgroundColor = UIColor.whiteColor()
        increase.setTitle("+", forState: UIControlState.Normal)
        increase.setTitleColor(UIColor.blackColor(), forState: .Normal)
        increase.titleLabel?.font = UIFont.systemFontOfSize(20)
        addSubview(increase)
    }
    
    func decreaseInputValue() {
        if input.keyboardType ==  UIKeyboardType.NumberPad {
            var result: Int = minIntValue
            let value = input.text
            if value != "" {
                result = (value! as NSString).integerValue
                result -= 1
            }
            if result < minIntValue {
                result = minIntValue
            }
            input.text = processTextFieldValue("\(result)")
        } else {
            var result: Float = minFloatValue
            let value = input.text
            if value != "" {
                result = (value! as NSString).floatValue
                result -= step
            }
            if result < minFloatValue {
                result = minFloatValue
            }
            input.text = processTextFieldValue("\(result)")
        }
        dataSource?.stepperTextFieldValueChanged?(input)
    }
    
    func increaseInputValue() {
        if input.keyboardType ==  UIKeyboardType.NumberPad {
            var result: Int = minIntValue
            let value = input.text
            if value != "" {
                result = (value! as NSString).integerValue
                result += 1
            }
            if result > maxIntValue {
                result = maxIntValue
            }
            input.text = processTextFieldValue("\(result)")
        } else {
            var result: Float = minFloatValue
            let value = input.text
            if value != "" {
                result = (value! as NSString).floatValue
                result += step
            }
            if result > maxFloatValue {
                result = maxFloatValue
            }
            input.text = processTextFieldValue("\(result)")
        }
        dataSource?.stepperTextFieldValueChanged?(input)
    }
    
    func processTextFieldValue(text: String) -> String {
        var result = text
        if result == "" {
            return result
        }
        if let _ = text.rangeOfString(".") {
            while result.hasSuffix("0") {
                result = (result as NSString).substringToIndex(result.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) - 1)
            }
            if result.hasSuffix(".") {
                result = (result as NSString).substringToIndex(result.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) - 1)
            }
        }
        return result
    }

}
