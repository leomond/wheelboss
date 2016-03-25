//
//  OrderConfirmViewController.swift
//  WheelBossDesign
//
//  Created by 李秋声 on 16/2/8.
//  Copyright © 2016年 Leomond. All rights reserved.
//

import UIKit

class OrderConfirmViewController: BaseWithBackViewController, UITextFieldDelegate, SelectViewDataSource, UIPopoverPresentationControllerDelegate, PulldownListViewControllerDataSource, SelectInputViewDataSource, PulldownGroupListViewControllerDataSource, UIScrollViewDelegate, UIGestureRecognizerDelegate, UITextViewDelegate, LoginDialogDelegate, LeomondHttpDelegate, StepperViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var orderInfoView: OrderConfirmScrollView! {
        didSet {
            orderInfoView.carInfoView.uploadDrivingLicense.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "uploadDrivingLicense"))
            orderInfoView.carInfoView.uploadDrivingLicense.userInteractionEnabled = true
            orderInfoView.carInfoView.uploadTyre.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "uploadTyre"))
            orderInfoView.carInfoView.uploadTyre.userInteractionEnabled = true
            let tapped = UITapGestureRecognizer(target: self, action: "tapDown")
            tapped.delegate = self
            orderInfoView.addGestureRecognizer(tapped)
            orderInfoView.productInfoView.productionTechnologyValue.dataSource = self
            orderInfoView.productInfoView.centerCoverValue.dataSource = self
            orderInfoView.productInfoView.tirePressureHoleValue.dataSource = self
            orderInfoView.productInfoView.brakeDIscValue.dataSource = self
            orderInfoView.carInfoView.carBrandValue.dataSource = self
            orderInfoView.carInfoView.carModelValue.dataSource = self
            orderInfoView.carInfoView.productDateValue.dataSource = self
            
            orderInfoView.carInfoView.carBrandValue.input.delegate = self
            orderInfoView.carInfoView.carModelValue.input.delegate = self
            orderInfoView.carInfoView.productDateValue.input.delegate = self
            orderInfoView.productInfoView.frontCountValue.input.delegate = self
            orderInfoView.productInfoView.rearCountValue.input.delegate = self
            orderInfoView.productInfoView.frontSizeValue.input.delegate = self
            orderInfoView.productInfoView.rearSizeValue.input.delegate = self
            orderInfoView.productInfoView.frontWidthValue.input.delegate = self
            orderInfoView.productInfoView.rearWidthValue.input.delegate = self
            orderInfoView.productInfoView.frontPcdValue.count.input.delegate = self
            orderInfoView.productInfoView.frontPcdValue.value.input.delegate = self
            orderInfoView.productInfoView.rearPcdValue.count.input.delegate = self
            orderInfoView.productInfoView.rearPcdValue.value.input.delegate = self
            orderInfoView.productInfoView.frontCbdValue.input.delegate = self
            orderInfoView.productInfoView.rearCbdValue.input.delegate = self
            orderInfoView.productInfoView.frontEtValue.input.delegate = self
            orderInfoView.productInfoView.rearEtValue.input.delegate = self
            orderInfoView.custInfoView.custNameValue.input.delegate = self
            orderInfoView.custInfoView.phoneValue.input.delegate = self
            orderInfoView.custInfoView.custMsgValue.delegate = self
            
            orderInfoView.productInfoView.frontCountValue.dataSource = self
            orderInfoView.productInfoView.rearCountValue.dataSource = self
            
            orderInfoView.carInfoView.carModelValue.input.addTarget(self, action: "valueChanged:", forControlEvents: UIControlEvents.EditingChanged)
            orderInfoView.productInfoView.frontCountValue.input.addTarget(self, action: "valueChanged:", forControlEvents: UIControlEvents.EditingChanged)
            orderInfoView.productInfoView.rearCountValue.input.addTarget(self, action: "valueChanged:", forControlEvents: UIControlEvents.EditingChanged)
            
            orderInfoView.delegate = self
        }
    }
    @IBOutlet weak var submitButton: UIButton!
    
    var seriesName: String = ""
    
    var wheelInfo: WheelBossInfo?
    
    var lwColor: String = ""
    var lwImageName: String?
    
    var lyColor: String = ""
    var lyImageName: String?
    
    var lfColor: String = ""
    var lfImageName: String?
    
    var ordertype: String = ""
    
    var lunguPicture: UIImage?
    
    var picutresInfo: PicturesInfo?
    
    private var keyboardHeight: CGFloat = 400
    
    var selectedView: UIView?
    
    var vehicleInfos: [NSDictionary]?
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    var orderId: String?
    
    var messageTips: String?
    
    var touchLoactionY: CGFloat = 0
    
    var currentUploadObject: String?
    
    private struct Constants {
        static let messageTitle = "错误提示"
        static let okButtonTitle = "确定"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        vehicleInfos = defaults.objectForKey(OrderConfirmInfo.CarInfoIdentifier) as? [NSDictionary] ?? [NSDictionary]()
        
//        orderInfoView.productInfoView.testImage.image = lunguPicture!
        
        if ordertype == "01" {
            orderInfoView.productInfoView.wheelTypeValue.text = seriesName
            orderInfoView.productInfoView.wheelModelValue.text = (wheelInfo?.displayName)!
//            orderInfoView.productInfoView.wheelColorForLf.color = lfColor
//            orderInfoView.productInfoView.wheelColorForly.color = lyColor
//            orderInfoView.productInfoView.wheelColorForLw.color = lwColor
            orderInfoView.productInfoView.wheelColorValue.display.text = "轮辋(\(WheelColorInfo.Colors[lwColor]!))+轮缘(\(WheelColorInfo.Colors[lyColor]!))+轮辐(\(WheelColorInfo.Colors[lfColor]!))"
            orderInfoView.productInfoView.productionTechnologyValue.pulldownData = getProductionTechnology()
        } else if ordertype == "03" {
            orderInfoView.productInfoView.wheelTypeValue.text = picutresInfo?.wheelseriesname
            orderInfoView.productInfoView.wheelModelValue.text = "CGCG\((picutresInfo?.wheeltype)!)"
            orderInfoView.productInfoView.productionTechnologyValue.display = (picutresInfo?.technical)!
            orderInfoView.productInfoView.productionTechnologyValue.pulldownData = [(picutresInfo?.technical)!]
            orderInfoView.productInfoView.wheelColorValue.display.text = picutresInfo?.chromaticalname
        }
        orderInfoView.productInfoView.wheelColorValue.image.image = lunguPicture
        
        
        let carInfoModuleHeight: CGFloat = orderInfoView.carInfoModule.titleHeight + orderInfoView.carInfoView.space * 2 + orderInfoView.carInfoView.height * 3 + orderInfoView.carInfoView.lineSpace * 2
        let productInfoModuleHeight: CGFloat = orderInfoView.productInfoModule.titleHeight + orderInfoView.productInfoView.space * 2 + orderInfoView.productInfoView.lineSpace * 8 + orderInfoView.productInfoView.height * 11 + orderInfoView.productInfoView.lineWidth + orderInfoView.productInfoView.spaceLine
        let custInfoModuleHeight: CGFloat = orderInfoView.custInfoModule.titleHeight + orderInfoView.custInfoView.space * 2 + orderInfoView.custInfoView.height * 3 + orderInfoView.custInfoView.lineSpace
        let height = orderInfoView.topSpace + carInfoModuleHeight + productInfoModuleHeight + custInfoModuleHeight + orderInfoView.moduleSpace * 2 + orderInfoView.buttonSpace
        orderInfoView.contentSize = CGSize(width: orderInfoView.bounds.width, height: height)
        orderInfoView.scrollEnabled = true
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillAppear:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardDidHide:", name: UIKeyboardDidHideNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "textFiledEditChanged:", name: UITextFieldTextDidChangeNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "textViewEditChanged:", name: UITextViewTextDidChangeNotification, object: nil)
        
        loadCarInfo()
        // Do any additional setup after loading the view.
    }
    
    func getProductionTechnology() -> [String] {
        if seriesName == "锻造直通" {
            if lwColor == lfColor && lfColor == lyColor {
                return ["车面不车边", "车边不车面"]
            } else {
                return ["套色"]
            }
        }
        if seriesName == "冷璇直通" {
            if lwColor == lfColor && lfColor == lyColor {
                return ["车面不车边"]
            } else {
                return ["套色"]
            }
        }
        return []
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func keyboardWillAppear(notification: NSNotification) {
        let keyboardinfo = notification.userInfo![UIKeyboardFrameBeginUserInfoKey]
        keyboardHeight = (keyboardinfo?.CGRectValue.size.height)!
    }
    
    func keyboardDidHide(notification: NSNotification) {
        resign()
    }
    
    func textFiledEditChanged(notification: NSNotification) {
        if let textField = notification.object as? UITextField {
            if textField.markedTextRange !=  nil {
                return
            }
            if textField == orderInfoView.carInfoView.carBrandValue.input {
                if var content = textField.text {
                    while content.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) > 30 {
                        content = content.substringToIndex(content.endIndex.advancedBy(-1))
                    }
                    textField.text = content
                }
            }
            if textField == orderInfoView.carInfoView.carModelValue.input {
                if var content = textField.text {
                    while content.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) > 30 {
                        content = content.substringToIndex(content.endIndex.advancedBy(-1))
                    }
                    textField.text = content
                }
            }
            if textField == orderInfoView.custInfoView.custNameValue.input {
                if var content = textField.text {
                    while content.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) > 30 {
                        content = content.substringToIndex(content.endIndex.advancedBy(-1))
                    }
                    textField.text = content
                }
            }
        }
    }
    
    func textViewEditChanged(notification: NSNotification) {
        if let textView = notification.object as? UITextView {
            if textView == orderInfoView.custInfoView.custMsgValue {
                if var content = textView.text {
                    while content.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) > 200 {
                        content = content.substringToIndex(content.endIndex.advancedBy(-1))
                    }
                    textView.text = content
                }
            }
        }
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if text == "" || textView.markedTextRange !=  nil {
            return true
        }
        if textView == orderInfoView.custInfoView.custMsgValue {
            if (textView.text?.lengthOfBytesUsingEncoding(NSUTF8StringEncoding))! + text.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) > 200 {
                return false
            } else {
                return true
            }
        }
        return true
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if string == "" {
            return true
        }
        // 汽车品牌
        if textField == orderInfoView.carInfoView.carBrandValue.input {
            if textField.markedTextRange !=  nil {
                return true
            }
            if (textField.text?.lengthOfBytesUsingEncoding(NSUTF8StringEncoding))! + string.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) > 30 {
                return false
            } else {
                return true
            }
        }
        // 汽车型号
        if textField == orderInfoView.carInfoView.carModelValue.input {
            if textField.markedTextRange !=  nil {
                return true
            }
            if (textField.text?.lengthOfBytesUsingEncoding(NSUTF8StringEncoding))! + string.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) > 30 {
                return false
            } else {
                return true
            }
        }
        // 生产年份输入限制
        if textField == orderInfoView.carInfoView.productDateValue.input {
            if textField.text?.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) == 0 {
                switch string {
                case "1", "2":
                    return true
                default:
                    return false
                }
            } else if textField.text?.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) < 4 {
                switch string {
                case "0", "1", "2", "3", "4", "5", "6", "7", "8", "9":
                    return true
                default:
                    return false
                }
            } else {
                return false
            }
        }
        // 前后轮数量限制
        if textField == orderInfoView.productInfoView.frontCountValue.input || textField == orderInfoView.productInfoView.rearCountValue.input {
            if textField.text?.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) == 0 {
                switch string {
                case "0", "1", "2":
                    return true
                default:
                    return false
                }
            } else if textField.text?.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) == 1 {
                switch string {
                case "0", "1", "2":
                    textField.text = ""
                    return true
                default:
                    return false
                }
            } else {
                return false
            }
        }
        // pcd hole
        if textField == orderInfoView.productInfoView.frontPcdValue.count.input || textField == orderInfoView.productInfoView.rearPcdValue.count.input {
            if textField.text?.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) == 0 {
                switch string {
                case "1", "2", "3", "4", "5", "6", "7", "8", "9":
                    return true
                default:
                    return false
                }
            } else {
                return false
            }
        }
        // 宽度
        if textField == orderInfoView.productInfoView.frontWidthValue.input || textField == orderInfoView.productInfoView.rearWidthValue.input {
            if textField.text?.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) == 0 {
                switch string {
                case "1", "2", "3", "4", "5", "6", "7", "8", "9":
                    return true
                default:
                    return false
                }
            } else if textField.text?.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) == 1 {
                switch string {
                case "0", "1", "2", "3", "4", "5", "6", "7", "8", "9":
                    return true
                default:
                    return false
                }
            } else if textField.text?.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) == 2 {
                switch string {
                case ".":
                    return true
                default:
                    return false
                }
            } else if textField.text?.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) == 3 {
                switch string {
                case "5":
                    return true
                default:
                    return false
                }
            } else {
                return false
            }
        }
        // 孔距pcd
        if textField == orderInfoView.productInfoView.frontPcdValue.value.input || textField == orderInfoView.productInfoView.rearPcdValue.value.input {
            return checkTextFieldForDouble(textField, string: string, dotLeftLenght: 3, dotRightLenght: 2)
        }
        // 中心孔cbd
        if textField == orderInfoView.productInfoView.frontCbdValue.input || textField == orderInfoView.productInfoView.rearCbdValue.input {
            return checkTextFieldForDouble(textField, string: string, dotLeftLenght: 2, dotRightLenght: 2)
        }
        // 尺寸 偏距et
        if textField == orderInfoView.productInfoView.frontSizeValue.input || textField == orderInfoView.productInfoView.rearSizeValue.input  || textField == orderInfoView.productInfoView.frontEtValue.input || textField == orderInfoView.productInfoView.rearEtValue.input {
            if textField.text?.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) == 0 {
                switch string {
                case "1", "2", "3", "4", "5", "6", "7", "8", "9":
                    return true
                default:
                    return false
                }
            } else if textField.text?.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) == 1 {
                switch string {
                case "0", "1", "2", "3", "4", "5", "6", "7", "8", "9":
                    return true
                default:
                    return false
                }
            } else {
                return false
            }
        }
        // 客户姓名
        if textField == orderInfoView.custInfoView.custNameValue.input {
            if textField.markedTextRange !=  nil {
                return true
            }
            if (textField.text?.lengthOfBytesUsingEncoding(NSUTF8StringEncoding))! + string.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) > 30 {
                return false
            } else {
                return true
            }
        }
        // 手机号码
        if textField == orderInfoView.custInfoView.phoneValue.input {
            if textField.text?.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) == 0 {
                switch string {
                case "1":
                    return true
                default:
                    return false
                }
            } else if textField.text?.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) == 1 {
                switch string {
                case "3", "4", "5", "7", "8":
                    return true
                default:
                    return false
                }
            } else if textField.text?.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) < 11 {
                switch string {
                case "0", "1", "2", "3", "4", "5", "6", "7", "8", "9":
                    return true
                default:
                    return false
                }
            } else {
                return false
            }
        }
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        if textField.keyboardType == .DecimalPad || textField.keyboardType == .NumberPad {
            textField.text = processTextFieldValue(textField.text!)
        }
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
    
    func checkTextFieldForDouble(textField: UITextField, string: String, dotLeftLenght: Int, dotRightLenght: Int) -> Bool {
        if textField.text?.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) == 0 {
            switch string {
            case "0", "1", "2", "3", "4", "5", "6", "7", "8", "9":
                return true
            default:
                return false
            }
        } else if textField.text?.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) == 1 {
            if textField.text == "0" {
                switch string {
                case ".":
                    return true
                case "0", "1", "2", "3", "4", "5", "6", "7", "8", "9":
                    textField.text = ""
                    return true
                default:
                    return false
                }
            }
        } else if textField.text?.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) < dotLeftLenght + dotRightLenght + 1 {
            switch string {
            case "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", ".":
                if let range =  textField.text?.rangeOfString(".") {
                    if string == "." {
                        return false
                    }
                    let maxlength = ("\(range.endIndex)" as NSString).integerValue + dotRightLenght
                    if maxlength == textField.text?.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) {
                        return false
                    }
                } else if textField.text?.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) >= dotLeftLenght && string != "." {
                    return false
                }
                return true
            default:
                return false
            }
        } else {
            return false
        }
        return false
    }
    
    private func resign() {
        if orderInfoView.carInfoView.carBrandValue.input.isFirstResponder() {
            orderInfoView.carInfoView.carBrandValue.input.resignFirstResponder()
        }
        if orderInfoView.carInfoView.carModelValue.input.isFirstResponder() {
            orderInfoView.carInfoView.carModelValue.input.resignFirstResponder()
        }
        if orderInfoView.carInfoView.productDateValue.input.isFirstResponder() {
            orderInfoView.carInfoView.productDateValue.input.resignFirstResponder()
            if orderInfoView.carInfoView.productDateValue.input.text?.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) == 4 {
                autoFillProductInfo()
            }
        }
        if orderInfoView.productInfoView.frontCountValue.input.isFirstResponder() {
            orderInfoView.productInfoView.frontCountValue.input.resignFirstResponder()
        }
        if orderInfoView.productInfoView.rearCountValue.input.isFirstResponder() {
            orderInfoView.productInfoView.rearCountValue.input.resignFirstResponder()
        }
        if orderInfoView.productInfoView.frontSizeValue.input.isFirstResponder() {
            orderInfoView.productInfoView.frontSizeValue.input.resignFirstResponder()
        }
        if orderInfoView.productInfoView.rearSizeValue.input.isFirstResponder() {
            orderInfoView.productInfoView.rearSizeValue.input.resignFirstResponder()
        }
        if orderInfoView.productInfoView.frontWidthValue.input.isFirstResponder() {
            orderInfoView.productInfoView.frontWidthValue.input.resignFirstResponder()
        }
        if orderInfoView.productInfoView.rearWidthValue.input.isFirstResponder() {
            orderInfoView.productInfoView.rearWidthValue.input.resignFirstResponder()
        }
        if orderInfoView.productInfoView.frontPcdValue.count.input.isFirstResponder() {
            orderInfoView.productInfoView.frontPcdValue.count.input.resignFirstResponder()
        }
        if orderInfoView.productInfoView.frontPcdValue.value.input.isFirstResponder() {
            orderInfoView.productInfoView.frontPcdValue.value.input.resignFirstResponder()
        }
        if orderInfoView.productInfoView.rearPcdValue.count.input.isFirstResponder() {
            orderInfoView.productInfoView.rearPcdValue.count.input.resignFirstResponder()
        }
        if orderInfoView.productInfoView.rearPcdValue.value.input.isFirstResponder() {
            orderInfoView.productInfoView.rearPcdValue.value.input.resignFirstResponder()
        }
        if orderInfoView.productInfoView.frontCbdValue.input.isFirstResponder() {
            orderInfoView.productInfoView.frontCbdValue.input.resignFirstResponder()
        }
        if orderInfoView.productInfoView.rearCbdValue.input.isFirstResponder() {
            orderInfoView.productInfoView.rearCbdValue.input.resignFirstResponder()
        }
        if orderInfoView.productInfoView.frontEtValue.input.isFirstResponder() {
            orderInfoView.productInfoView.frontEtValue.input.resignFirstResponder()
        }
        if orderInfoView.productInfoView.rearEtValue.input.isFirstResponder() {
            orderInfoView.productInfoView.rearEtValue.input.resignFirstResponder()
        }
        if orderInfoView.custInfoView.custNameValue.input.isFirstResponder() {
            orderInfoView.custInfoView.custNameValue.input.resignFirstResponder()
        }
        if orderInfoView.custInfoView.phoneValue.input.isFirstResponder() {
            orderInfoView.custInfoView.phoneValue.input.resignFirstResponder()
        }
        if orderInfoView.custInfoView.custMsgValue.isFirstResponder() {
            orderInfoView.custInfoView.custMsgValue.resignFirstResponder()
        }
        self.view.becomeFirstResponder()
        tapOnce()
    }
    
    func tapOnce(){
        UIView.animateWithDuration(0.2, animations: {
            self.view.frame.origin.y = 0
        })
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        let distance = self.view.bounds.size.height - touchLoactionY - textField.bounds.size.height
        UIView.animateWithDuration(0.4) { () -> Void in
            let viewY: CGFloat = distance - self.keyboardHeight
            self.view.frame.origin.y = min(viewY, 0)
        }
        return true
    }
    
    func textViewShouldBeginEditing(textView: UITextView) -> Bool {
        let distance = self.view.bounds.size.height - touchLoactionY - textView.bounds.size.height
        UIView.animateWithDuration(0.4) { () -> Void in
            let viewY: CGFloat = distance - self.keyboardHeight
            self.view.frame.origin.y = min(viewY, 0)
        }
        return true
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        resign()
    }
    
    func tapDown() {
        resign()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func back() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func submit(sender: UIButton) {
        resign()
        submitOrder()
    }
    
    func submitOrder() {
        let defaults = NSUserDefaults.standardUserDefaults()
        let info = defaults.objectForKey(SignInConstants.LoginStateMark)
        if let tokenInfo = info as? Dictionary<String, String> {
            if let loginInfo = tokenInfo["accesstoken"] {
                let formInfo = getFormInfo()
                if validFormInfo(formInfo) {
                    showAlert()
                    return
                }
                
                let token = loginInfo as String
                let parameters = [
                    "accesstoken": token,
                    "carinfo": dictionaryToJson(formInfo["carinfo"]!),
                    "goodinfo": dictionaryToJson(formInfo["goodinfo"]!),
                    "custmerinfo": dictionaryToJson(formInfo["custmerinfo"]!),
                    "ordertype": ordertype
                ]
                let reqHttp = LeomondHttp.init(identifier: "submitOrder", uri: URIConstants.OrderConfirm, parameters: parameters, loadingTips: true, viewController: self, subView: orderInfoView)
                reqHttp.delegate = self
                reqHttp.sendPostRequest()
            }
        }
    }
    
    func dictionaryToJson(dict: Dictionary<String, AnyObject>) -> String {
        let data = try! NSJSONSerialization.dataWithJSONObject(dict, options: NSJSONWritingOptions.PrettyPrinted)
        let strJson=NSString(data: data, encoding: NSUTF8StringEncoding)
        return strJson as! String
    }
    
    func showAlert() {
        let alertController = UIAlertController(title: Constants.messageTitle, message: messageTips, preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: Constants.okButtonTitle, style: UIAlertActionStyle.Default, handler: {
            (alertAction: UIAlertAction) -> () in
//            if message == Constants.pleaseInputUserName {
//                self.userName.textField.becomeFirstResponder()
//            }
//            if message == Constants.pleaseInputUserPwd {
//                self.userPwd.textField.becomeFirstResponder()
//            }
        })
        alertController.addAction(okAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func validFormInfo(formInfo: Dictionary<String, Dictionary<String, AnyObject>>) -> Bool {
        let carInfo = formInfo["carinfo"]
        let vehiclebrand = carInfo!["vehiclebrand"] as? String ?? ""
        if vehiclebrand == "" {
            messageTips = "请选择或输入汽车品牌"
            return true
        }
        let vehiclesers = carInfo!["vehiclesers"] as? String ?? ""
        if vehiclesers == "" {
            messageTips = "请选择或输入汽车型号"
            return true
        }
        let producetime = carInfo!["producetime"] as? String ?? ""
        if producetime == "" {
            messageTips = "请选择或输入生产年份"
            return true
        }
        
        let productInfo = formInfo["goodinfo"]
        let technical = productInfo!["technical"] as? String ?? ""
        if technical == "" {
            messageTips = "请选择生产工艺"
            return true
        }
        let wheelcap = productInfo!["wheelcap"] as? String ?? ""
        if wheelcap == "" {
            messageTips = "请选择中心盖"
            return true
        }
        let tyrepressure = productInfo!["tyrepressure"] as? String ?? ""
        if tyrepressure == "" {
            messageTips = "请选择胎压孔"
            return true
        }
        let brakedisc = productInfo!["brakedisc"] as? String ?? ""
        if brakedisc == "" {
            messageTips = "请选择刹车盘"
            return true
        }
        let wheelparmlist = productInfo!["wheelparmlist"] as? [Dictionary<String, String>] ?? [Dictionary<String, String>]()
        if wheelparmlist.count == 0 {
            messageTips = "请输入前轮或后轮数量"
            return true
        }
        var selected: Bool = false
        for wheelpara in wheelparmlist {
            var location: String = wheelpara["wheellocation"]!
            if location == "F" {
                location = "前轮"
            } else {
                location = "后轮"
            }
            let sum = wheelpara["sum"]
            if sum != "" && sum != "0" {
                selected = true
                let wheelsize = wheelpara["wheelsize"]
                if wheelsize == "" {
                    messageTips = "请输入\(location)尺寸"
                    return true
                }
                let wheelwidth = wheelpara["wheelwidth"]
                if wheelwidth == "" {
                    messageTips = "请输入\(location)宽度"
                    return true
                }
                let wheelhole = wheelpara["wheelhole"]
                if wheelhole == "" {
                    messageTips = "请输入\(location)孔距（PCD）数量"
                    return true
                }
                let wheelpcd = wheelpara["wheelpcd"]
                if wheelpcd == "" {
                    messageTips = "请输入\(location)孔距（PCD）的值"
                    return true
                }
                let wheelcbd = wheelpara["wheelcbd"]
                if wheelcbd == "" {
                    messageTips = "请输入\(location)中心孔（CBD）的值"
                    return true
                }
                let wheelet = wheelpara["wheelet"]
                if wheelet == "" {
                    messageTips = "请输入\(location)偏距（ET）的值"
                    return true
                }
            }
        }
        if !selected {
            messageTips = "请输入前轮或后轮数量"
            return true
        }
        let custInfo = formInfo["custmerinfo"]
        let carownername = custInfo!["carownername"] as? String ?? ""
        if carownername == "" {
            messageTips = "请输入客户姓名"
            return true
        }
        let carowertel = custInfo!["carowertel"] as? String ?? ""
        if carowertel == "" {
            messageTips = "请输入联系电话"
            return true
        }
        if carowertel.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) != 11 {
            messageTips = "请输入正确的手机号码"
            return true
        }
        return false
    }
    
    func getFormInfo() -> Dictionary<String, Dictionary<String, AnyObject>> {
        var result = Dictionary<String, Dictionary<String, AnyObject>>()
        var carInfo = Dictionary<String, AnyObject>()
        carInfo["vehiclebrand"] = orderInfoView.carInfoView.carBrandValue.input.text
        carInfo["vehiclesers"] = orderInfoView.carInfoView.carModelValue.input.text
        carInfo["producetime"] = orderInfoView.carInfoView.productDateValue.input.text
        if let drivinglicense = orderInfoView.carInfoView.uploadDrivingLicense.image {
            print(UIImageJPEGRepresentation(drivinglicense, 0.5)?.base64EncodedStringWithOptions(.EncodingEndLineWithLineFeed))
            carInfo["vehtralic"] = UIImageJPEGRepresentation(drivinglicense, 0.5)?.base64EncodedStringWithOptions(.EncodingEndLineWithLineFeed)
        }
        if let tyre = orderInfoView.carInfoView.uploadTyre.image {
            carInfo["tyre"] = UIImageJPEGRepresentation(tyre, 0.5)?.base64EncodedStringWithOptions(.EncodingEndLineWithLineFeed)
        }
        result["carinfo"] = carInfo
        
        var productInfo = Dictionary<String, AnyObject>()
        productInfo["wheelpic"] = UIImageJPEGRepresentation(lunguPicture!, 0.5)?.base64EncodedStringWithOptions(.EncodingEndLineWithLineFeed)
        productInfo["wheelid"] = wheelInfo?.name
        productInfo["technical"] = OrderConfirmInfo.ProductionTechnologyInfo[orderInfoView.productInfoView.productionTechnologyValue.display]
        if ordertype == "01" {
            productInfo["wheelseriesname"] = seriesName
            productInfo["wheeltype"] = wheelInfo?.name
        } else if ordertype == "03" {
            productInfo["wheelseriesname"] = picutresInfo?.wheelseriesname
            productInfo["wheeltype"] = picutresInfo?.wheeltype
        }
        
        productInfo["wheelcap"] = OrderConfirmInfo.CenterCoverInfo[orderInfoView.productInfoView.centerCoverValue.display]
        if ordertype == "01" {
            productInfo["spokecolor"] = lwColor
            productInfo["spokepicid"] = lwImageName
            productInfo["rimcolor"] = lfColor
            productInfo["rimpicid"] = lfImageName
            productInfo["flangecolor"] = lyColor
            productInfo["flangepicid"] = lyImageName
        } else if ordertype == "03" {
            productInfo["spokecolor"] = picutresInfo?.chromaticalid
            productInfo["rimcolor"] = picutresInfo?.chromaticalid
            productInfo["flangecolor"] = picutresInfo?.chromaticalid
        }
        productInfo["tyrepressure"] = OrderConfirmInfo.TirePressureHoleInfo[orderInfoView.productInfoView.tirePressureHoleValue.display]
        productInfo["brakedisc"] = OrderConfirmInfo.BrakeDiscInfo[orderInfoView.productInfoView.brakeDIscValue.display]
        var frontInfo = Dictionary<String, String>()
        frontInfo["sum"] = orderInfoView.productInfoView.frontCountValue.input.text
        frontInfo["wheellocation"] = "F"
        frontInfo["wheelsize"] = orderInfoView.productInfoView.frontSizeValue.input.text
        frontInfo["wheelwidth"] = orderInfoView.productInfoView.frontWidthValue.input.text
        frontInfo["wheelhole"] = orderInfoView.productInfoView.frontPcdValue.count.input.text
        frontInfo["wheelpcd"] = orderInfoView.productInfoView.frontPcdValue.value.input.text
        frontInfo["wheelcbd"] = orderInfoView.productInfoView.frontCbdValue.input.text
        frontInfo["wheelet"] = orderInfoView.productInfoView.frontEtValue.input.text
        var rearInfo = Dictionary<String, String>()
        rearInfo["sum"] = orderInfoView.productInfoView.rearCountValue.input.text
        rearInfo["wheellocation"] = "R"
        rearInfo["wheelsize"] = orderInfoView.productInfoView.rearSizeValue.input.text
        rearInfo["wheelwidth"] = orderInfoView.productInfoView.rearWidthValue.input.text
        rearInfo["wheelhole"] = orderInfoView.productInfoView.rearPcdValue.count.input.text
        rearInfo["wheelpcd"] = orderInfoView.productInfoView.rearPcdValue.value.input.text
        rearInfo["wheelcbd"] = orderInfoView.productInfoView.rearCbdValue.input.text
        rearInfo["wheelet"] = orderInfoView.productInfoView.rearEtValue.input.text
        let wheelParmList = [frontInfo, rearInfo]
        productInfo["wheelparmlist"] = wheelParmList
        result["goodinfo"] = productInfo
        
        var custInfo = Dictionary<String, String>()
        custInfo["carownername"] = orderInfoView.custInfoView.custNameValue.input.text
        custInfo["carowertel"] = orderInfoView.custInfoView.phoneValue.input.text
        custInfo["comment"] = orderInfoView.custInfoView.custMsgValue.text
        result["custmerinfo"] = custInfo
        return result
    }
    
    func clickSelectView(tableData: [String], viewObject: SelectView) {
        resign()
        selectedView = viewObject
        let story = UIStoryboard(name: "Main", bundle: nil)
        let vc = story.instantiateViewControllerWithIdentifier("PullDownList") as! PulldownListViewController
        vc.tableData = tableData
        vc.tableWidth = viewObject.bounds.size.width
        vc.dataSource = self
        vc.modalPresentationStyle = UIModalPresentationStyle.Popover
        let popOverController = vc.popoverPresentationController! as UIPopoverPresentationController
        popOverController.delegate = self
        popOverController.sourceView = viewObject
        popOverController.sourceRect = viewObject.bounds
        popOverController.permittedArrowDirections = .Up
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.None
    }
    
    func selectTableInfo(info: String) {
        if let selected = selectedView as? SelectView {
            selected.display = info
        } else if let selected = selectedView as? SelectInputView {
            selected.input.text = info
            if selected.id == "model" {
                orderInfoView.carInfoView.productDateValue.input.text = ""
            }
            if selected.id == "year" {
                autoFillProductInfo()
            }
        }
    }
    
    func autoFillProductInfo() {
        let carBrand = orderInfoView.carInfoView.carBrandValue.input.text
        let carModel = orderInfoView.carInfoView.carModelValue.input.text
        let productYear = orderInfoView.carInfoView.productDateValue.input.text
        if carBrand != "" && carModel != "" && productYear != "" {
            for carInfo in vehicleInfos! {
                let vehiclebrand = carInfo["vehiclebrand"] as? String ?? ""
                let vehiclesers = carInfo["vehiclesers"] as? String ?? ""
                let probgtime = carInfo["probgtime"] as? String ?? ""
                let proedtime = carInfo["proedtime"] as? String ?? ""
                if vehiclebrand == carBrand && vehiclesers == carModel && productYear >= probgtime && productYear <= proedtime {
                    if var wheelcbd = carInfo["wheelcbd"] as? String {
                        wheelcbd = processFloatValue(wheelcbd, precision: 2)
                        orderInfoView.productInfoView.frontCbdValue.input.text = wheelcbd
                        orderInfoView.productInfoView.rearCbdValue.input.text = wheelcbd
                    }
                    if var wheelet = carInfo["wheelet"] as? String {
                        wheelet = processFloatValue(wheelet, precision: 0)
                        orderInfoView.productInfoView.frontEtValue.input.text = wheelet
                        orderInfoView.productInfoView.rearEtValue.input.text = wheelet
                    }
                    if var wheelsize = carInfo["wheelsize"] as? String {
                        wheelsize = processFloatValue(wheelsize, precision: 0)
                        orderInfoView.productInfoView.frontSizeValue.input.text = wheelsize
                        orderInfoView.productInfoView.rearSizeValue.input.text = wheelsize
                    }
                    if var wheelwidth = carInfo["wheelwidth"] as? String {
                        wheelwidth = processFloatValue(wheelwidth, precision: 1)
                        orderInfoView.productInfoView.frontWidthValue.input.text = wheelwidth
                        orderInfoView.productInfoView.rearWidthValue.input.text = wheelwidth
                    }
                    if var wheelpcd = carInfo["wheelpcd"] as? String {
                        wheelpcd = processFloatValue(wheelpcd, precision: 2)
                        orderInfoView.productInfoView.frontPcdValue.value.input.text = wheelpcd
                        orderInfoView.productInfoView.rearPcdValue.value.input.text = wheelpcd
                    }
                    if let wheelhole = carInfo["wheelhole"] as? String {
                        orderInfoView.productInfoView.frontPcdValue.count.input.text = wheelhole
                        orderInfoView.productInfoView.rearPcdValue.count.input.text = wheelhole
                    }
                    return
                }
            }
        }
    }
    
    func processFloatValue(value: String, precision: Int) -> String {
        var result = value
        if let dotPosition = value.rangeOfString(".") {
            let exceptLength: Int = ("\(dotPosition.endIndex)" as NSString).integerValue + precision
            if value.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) > exceptLength {
                result = (result as NSString).substringToIndex(exceptLength)
            }
            while result.hasSuffix("0") {
                result = (result as NSString).substringToIndex(result.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) - 1)
            }
            if result.hasSuffix(".") {
                result = (result as NSString).substringToIndex(result.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) - 1)
            }
        }
        return result
    }
    
    func doPulldownAction(viewObject: SelectInputView) {
        resign()
        switch viewObject.id {
        case "brand":
            doBrandPop(viewObject)
            break
        default:
            doDefaultPop(viewObject)
        }
        
    }
    
    func doBrandPop(viewObject: SelectInputView) {
        var tableData = gerBrandInfo()
        if tableData.count == 0 {
            return
        }
        selectedView = viewObject
        let story = UIStoryboard(name: "Main", bundle: nil)
        let vc = story.instantiateViewControllerWithIdentifier("PullDownGroupList") as! PulldownGroupListViewController
        let sectionData = tableData["sectionInfo"]
        tableData.removeValueForKey("sectionInfo")
        vc.sectionData = sectionData
        vc.tableData = tableData
        vc.tableWidth = viewObject.bounds.size.width
        vc.dataSource = self
        vc.modalPresentationStyle = UIModalPresentationStyle.Popover
        let popOverController = vc.popoverPresentationController! as UIPopoverPresentationController
        popOverController.delegate = self
        popOverController.sourceView = viewObject
        popOverController.sourceRect = viewObject.bounds
        popOverController.permittedArrowDirections = .Up
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    func gerBrandInfo() -> Dictionary<String, [String]> {
        var result = Dictionary<String, [String]>()
        var section = [String]()
        for carInfo in vehicleInfos! {
            if let brandlabel = carInfo["brandlabel"] as? String {
                if !section.contains(brandlabel) {
                    section += [brandlabel]
                }
                if let vehiclebrand = carInfo["vehiclebrand"] as? String {
                    let sectionInfo = result[brandlabel] ?? [String]()
                    if !sectionInfo.contains(vehiclebrand) {
                        result[brandlabel] = sectionInfo + [vehiclebrand]
                    }
                }
            }
        }
        if section.count > 0 {
            result["sectionInfo"] = section
        }
        return result
    }
    
    func selectedGroupPulldownInfo(info: String) {
        if let selected = selectedView as? SelectInputView {
            selected.input.text = info
            if selected.id == "brand" {
                orderInfoView.carInfoView.carModelValue.input.text = ""
                orderInfoView.carInfoView.productDateValue.input.text = ""
            }
        }
    }
    
    func doDefaultPop(viewObject: SelectInputView) {
        let tableData = getTableData(viewObject.id)
        if tableData.count == 0 {
            return
        }
        selectedView = viewObject
        let story = UIStoryboard(name: "Main", bundle: nil)
        let vc = story.instantiateViewControllerWithIdentifier("PullDownList") as! PulldownListViewController
        vc.tableData = tableData
        vc.tableWidth = viewObject.bounds.size.width
        vc.dataSource = self
        vc.modalPresentationStyle = UIModalPresentationStyle.Popover
        let popOverController = vc.popoverPresentationController! as UIPopoverPresentationController
        popOverController.delegate = self
        popOverController.sourceView = viewObject
        popOverController.sourceRect = viewObject.bounds
        popOverController.permittedArrowDirections = .Up
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    func getTableData(id: String) -> [String] {
        var tableData = [String]()
        switch id {
        case "model":
            let brand = orderInfoView.carInfoView.carBrandValue.input.text
            if brand == "" {
                break
            }
            for carInfo in vehicleInfos! {
                if let vehiclebrand = carInfo["vehiclebrand"] as? String {
                    if vehiclebrand == brand {
                        if let vehiclesers = carInfo["vehiclesers"] as? String {
                            if !tableData.contains(vehiclesers) {
                                tableData += [vehiclesers]
                            }
                        }
                    }
                }
            }
            break
        case "year":
            let brand = orderInfoView.carInfoView.carBrandValue.input.text
            let model = orderInfoView.carInfoView.carModelValue.input.text
            if brand == "" || model == "" {
                break
            }
            for carInfo in vehicleInfos! {
                if let vehiclebrand = carInfo["vehiclebrand"] as? String {
                    if let vehiclesers = carInfo["vehiclesers"] as? String {
                        if vehiclebrand == brand && vehiclesers == model {
                            // MARK
                            let probgtime = carInfo["probgtime"] as? String
                            let proedtime = carInfo["proedtime"] as? String
                            if probgtime != "" && proedtime != "" {
                                if var startYear = Int(probgtime!)  {
                                    let endYear = Int(proedtime!)
                                    while startYear <= endYear {
                                        let strYear = "\(startYear)"
                                        if !tableData.contains(strYear) {
                                            tableData += [strYear]
                                        }
                                        startYear++
                                    }
                                }
                            }
                        }
                        tableData.sortInPlace{$0 < $1}
                    }
                }
            }
            break
        default:
            break
        }
        
        return tableData
    }
    
    func loadCarInfo() {
        let defaults = NSUserDefaults.standardUserDefaults()
        let info = defaults.objectForKey(SignInConstants.LoginStateMark)
        if let tokenInfo = info as? Dictionary<String, String> {
            if let loginInfo = tokenInfo["accesstoken"] {
                let token = loginInfo as String
                let parameters = [
                    "accesstoken": token
                ]
                let reqHttp = LeomondHttp.init(identifier: "getCarInfo", uri: URIConstants.QueryCarInfo, parameters: parameters, loadingTips: false, viewController: self, subView: view)
                reqHttp.delegate = self
                reqHttp.sendPostRequest()
            }
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func stepperTextFieldValueChanged(textField: UITextField) {
        if textField == orderInfoView.productInfoView.frontCountValue.input {
            if textField.text == "0" {
                orderInfoView.productInfoView.frontSizeValue.increase.userInteractionEnabled = false
                orderInfoView.productInfoView.frontSizeValue.increase.enabled = false
                orderInfoView.productInfoView.frontSizeValue.increase.setTitleColor(UIColor(red: 153 / 255, green: 153 / 255, blue: 153 / 255, alpha: 1), forState: .Disabled)
                orderInfoView.productInfoView.frontSizeValue.decrease.userInteractionEnabled = false
                orderInfoView.productInfoView.frontSizeValue.decrease.enabled = false
                orderInfoView.productInfoView.frontSizeValue.decrease.setTitleColor(UIColor(red: 153 / 255, green: 153 / 255, blue: 153 / 255, alpha: 1), forState: .Disabled)
                orderInfoView.productInfoView.frontSizeValue.input.enabled = false
                orderInfoView.productInfoView.frontSizeValue.input.textColor = UIColor(red: 153 / 255, green: 153 / 255, blue: 153 / 255, alpha: 1)
                orderInfoView.productInfoView.frontWidthValue.increase.userInteractionEnabled = false
                orderInfoView.productInfoView.frontWidthValue.increase.enabled = false
                orderInfoView.productInfoView.frontWidthValue.increase.setTitleColor(UIColor(red: 153 / 255, green: 153 / 255, blue: 153 / 255, alpha: 1), forState: .Disabled)
                orderInfoView.productInfoView.frontWidthValue.decrease.userInteractionEnabled = false
                orderInfoView.productInfoView.frontWidthValue.decrease.enabled = false
                orderInfoView.productInfoView.frontWidthValue.decrease.setTitleColor(UIColor(red: 153 / 255, green: 153 / 255, blue: 153 / 255, alpha: 1), forState: .Disabled)
                orderInfoView.productInfoView.frontWidthValue.input.enabled = false
                orderInfoView.productInfoView.frontWidthValue.input.textColor = UIColor(red: 153 / 255, green: 153 / 255, blue: 153 / 255, alpha: 1)
                orderInfoView.productInfoView.frontPcdValue.count.input.enabled = false
                orderInfoView.productInfoView.frontPcdValue.count.input.textColor = UIColor(red: 153 / 255, green: 153 / 255, blue: 153 / 255, alpha: 1)
                orderInfoView.productInfoView.frontPcdValue.value.input.enabled = false
                orderInfoView.productInfoView.frontPcdValue.value.input.textColor = UIColor(red: 153 / 255, green: 153 / 255, blue: 153 / 255, alpha: 1)
                orderInfoView.productInfoView.frontCbdValue.input.enabled = false
                orderInfoView.productInfoView.frontCbdValue.input.textColor = UIColor(red: 153 / 255, green: 153 / 255, blue: 153 / 255, alpha: 1)
                orderInfoView.productInfoView.frontEtValue.input.enabled = false
                orderInfoView.productInfoView.frontEtValue.input.textColor = UIColor(red: 153 / 255, green: 153 / 255, blue: 153 / 255, alpha: 1)
            } else {
                orderInfoView.productInfoView.frontSizeValue.increase.userInteractionEnabled = true
                orderInfoView.productInfoView.frontSizeValue.increase.enabled = true
                orderInfoView.productInfoView.frontSizeValue.decrease.userInteractionEnabled = true
                orderInfoView.productInfoView.frontSizeValue.decrease.enabled = true
                orderInfoView.productInfoView.frontSizeValue.input.enabled = true
                orderInfoView.productInfoView.frontSizeValue.input.textColor = UIColor.blackColor()
                orderInfoView.productInfoView.frontWidthValue.increase.userInteractionEnabled = true
                orderInfoView.productInfoView.frontWidthValue.increase.enabled = true
                orderInfoView.productInfoView.frontWidthValue.decrease.userInteractionEnabled = true
                orderInfoView.productInfoView.frontWidthValue.decrease.enabled = true
                orderInfoView.productInfoView.frontWidthValue.input.enabled = true
                orderInfoView.productInfoView.frontWidthValue.input.textColor = UIColor.blackColor()
                orderInfoView.productInfoView.frontPcdValue.count.input.enabled = true
                orderInfoView.productInfoView.frontPcdValue.count.input.textColor = UIColor.blackColor()
                orderInfoView.productInfoView.frontPcdValue.value.input.enabled = true
                orderInfoView.productInfoView.frontPcdValue.value.input.textColor = UIColor.blackColor()
                orderInfoView.productInfoView.frontCbdValue.input.enabled = true
                orderInfoView.productInfoView.frontCbdValue.input.textColor = UIColor.blackColor()
                orderInfoView.productInfoView.frontEtValue.input.enabled = true
                orderInfoView.productInfoView.frontEtValue.input.textColor = UIColor.blackColor()
            }
        }
        if textField == orderInfoView.productInfoView.rearCountValue.input {
            if textField.text == "0" {
                orderInfoView.productInfoView.rearSizeValue.increase.userInteractionEnabled = false
                orderInfoView.productInfoView.rearSizeValue.increase.enabled = false
                orderInfoView.productInfoView.rearSizeValue.increase.setTitleColor(UIColor(red: 153 / 255, green: 153 / 255, blue: 153 / 255, alpha: 1), forState: .Disabled)
                orderInfoView.productInfoView.rearSizeValue.decrease.userInteractionEnabled = false
                orderInfoView.productInfoView.rearSizeValue.decrease.enabled = false
                orderInfoView.productInfoView.rearSizeValue.decrease.setTitleColor(UIColor(red: 153 / 255, green: 153 / 255, blue: 153 / 255, alpha: 1), forState: .Disabled)
                orderInfoView.productInfoView.rearSizeValue.input.enabled = false
                orderInfoView.productInfoView.rearSizeValue.input.textColor = UIColor(red: 153 / 255, green: 153 / 255, blue: 153 / 255, alpha: 1)
                orderInfoView.productInfoView.rearWidthValue.increase.userInteractionEnabled = false
                orderInfoView.productInfoView.rearWidthValue.increase.enabled = false
                orderInfoView.productInfoView.rearWidthValue.increase.setTitleColor(UIColor(red: 153 / 255, green: 153 / 255, blue: 153 / 255, alpha: 1), forState: .Disabled)
                orderInfoView.productInfoView.rearWidthValue.decrease.userInteractionEnabled = false
                orderInfoView.productInfoView.rearWidthValue.decrease.enabled = false
                orderInfoView.productInfoView.rearWidthValue.decrease.setTitleColor(UIColor(red: 153 / 255, green: 153 / 255, blue: 153 / 255, alpha: 1), forState: .Disabled)
                orderInfoView.productInfoView.rearWidthValue.input.enabled = false
                orderInfoView.productInfoView.rearWidthValue.input.textColor = UIColor(red: 153 / 255, green: 153 / 255, blue: 153 / 255, alpha: 1)
                orderInfoView.productInfoView.rearPcdValue.count.input.enabled = false
                orderInfoView.productInfoView.rearPcdValue.count.input.textColor = UIColor(red: 153 / 255, green: 153 / 255, blue: 153 / 255, alpha: 1)
                orderInfoView.productInfoView.rearPcdValue.value.input.enabled = false
                orderInfoView.productInfoView.rearPcdValue.value.input.textColor = UIColor(red: 153 / 255, green: 153 / 255, blue: 153 / 255, alpha: 1)
                orderInfoView.productInfoView.rearCbdValue.input.enabled = false
                orderInfoView.productInfoView.rearCbdValue.input.textColor = UIColor(red: 153 / 255, green: 153 / 255, blue: 153 / 255, alpha: 1)
                orderInfoView.productInfoView.rearEtValue.input.enabled = false
                orderInfoView.productInfoView.rearEtValue.input.textColor = UIColor(red: 153 / 255, green: 153 / 255, blue: 153 / 255, alpha: 1)
            } else {
                orderInfoView.productInfoView.rearSizeValue.increase.userInteractionEnabled = true
                orderInfoView.productInfoView.rearSizeValue.increase.enabled = true
                orderInfoView.productInfoView.rearSizeValue.decrease.userInteractionEnabled = true
                orderInfoView.productInfoView.rearSizeValue.decrease.enabled = true
                orderInfoView.productInfoView.rearSizeValue.input.enabled = true
                orderInfoView.productInfoView.rearSizeValue.input.textColor = UIColor.blackColor()
                orderInfoView.productInfoView.rearWidthValue.increase.userInteractionEnabled = true
                orderInfoView.productInfoView.rearWidthValue.increase.enabled = true
                orderInfoView.productInfoView.rearWidthValue.decrease.userInteractionEnabled = true
                orderInfoView.productInfoView.rearWidthValue.decrease.enabled = true
                orderInfoView.productInfoView.rearWidthValue.input.enabled = true
                orderInfoView.productInfoView.rearWidthValue.input.textColor = UIColor.blackColor()
                orderInfoView.productInfoView.rearPcdValue.count.input.enabled = true
                orderInfoView.productInfoView.rearPcdValue.count.input.textColor = UIColor.blackColor()
                orderInfoView.productInfoView.rearPcdValue.value.input.enabled = true
                orderInfoView.productInfoView.rearPcdValue.value.input.textColor = UIColor.blackColor()
                orderInfoView.productInfoView.rearCbdValue.input.enabled = true
                orderInfoView.productInfoView.rearCbdValue.input.textColor = UIColor.blackColor()
                orderInfoView.productInfoView.rearEtValue.input.enabled = true
                orderInfoView.productInfoView.rearEtValue.input.textColor = UIColor.blackColor()
            }
        }
    }
    
    func valueChanged(textField: UITextField) {
        if textField == orderInfoView.productInfoView.frontCountValue.input || textField == orderInfoView.productInfoView.rearCountValue.input {
            stepperTextFieldValueChanged(textField)
        }
        if textField.markedTextRange != nil {
            return
        }
        if let superView = textField.superview as? SelectInputView {
            switch superView.id {
            case "brand":
                
                break
            case "model":
                let brand = orderInfoView.carInfoView.carBrandValue.input.text
                if brand == "" {
                    break
                }
//                let model = textField.text
                
                break
            case "year":
                break
            default:
                break
            }
        }
        print("value changed:\(textField.text)")
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        resign()
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
        touchLoactionY = touch.locationInView(view).y
        return true
    }
    
    func loginDialogSuccessLogin() {
        submitOrder()
    }
    
    func willSendRequest(identifier: String, cover: UIActivityIndicatorView) {
        if identifier == "submitOrder" {
            cover.color = UIColor.grayColor()
        }
    }
    
    func responseError(identifier: String) {
        if identifier == "submitOrder" {
            messageTips = "系统错误！"
            showAlert()
        }
    }
    
    func parseJsonResultError(identifier: String) {
        if identifier == "submitOrder" {
            messageTips = "返回参数解析异常！"
            showAlert()
        }
    }
    
    func networkUnavailable(identifier: String) {
        messageTips = "您的网络当前不可用，请检查您的网络设置！"
        showAlert()
    }
    
    func endedSendRequestByJsonRespone(identifier: String, result: NSDictionary) {
        switch identifier {
        case "getCarInfo":
            processCarInfo(result)
            break
        case "submitOrder":
            processOrderSuccessInfo(result)
            break
        default:
            break
        }
    }
    
    func processCarInfo(result: NSDictionary) {
        let rspCode: NSString = result.objectForKey("code") as! NSString
        if rspCode == "0000" {
            let vehicleinfolist = result.objectForKey("vehicleinfolist") as! [NSDictionary]
            vehicleInfos = vehicleinfolist
            defaults.setObject(vehicleinfolist, forKey: OrderConfirmInfo.CarInfoIdentifier)
        }
    }
    
    func processOrderSuccessInfo(result: NSDictionary) {
        let rspCode: NSString = result.objectForKey("code") as! NSString
        if rspCode == "0000" {
            let orderno = result.objectForKey("orderno") as? NSString
            orderId = orderno as? String
            self.performSegueWithIdentifier("shouOrderSuccess", sender: self)
        } else if rspCode == "1004" {
            let signUp = LoginDialog.init(viewController: self, subView: orderInfoView)
            signUp.delgate = self
            signUp.showLoginDialog()
        } else {
            messageTips = result.objectForKey("message") as? String
            showAlert()
        }
    }
    
    func uploadDrivingLicense() {
        resign()
        currentUploadObject = "drivinglicense"
        let alertController = UIAlertController(title: "提示", message: "上传驾驶证照片", preferredStyle: UIAlertControllerStyle.ActionSheet)
        alertController.modalPresentationStyle = .Popover
        let popOverController = alertController.popoverPresentationController! as UIPopoverPresentationController
        popOverController.sourceView = orderInfoView.carInfoView.uploadDrivingLicense
        popOverController.sourceRect = orderInfoView.carInfoView.uploadDrivingLicense.bounds
        popOverController.permittedArrowDirections = .Up
        self.presentViewController(alertController, animated: true) { () -> Void in
            let takeAction = UIAlertAction(title: "拍照", style: UIAlertActionStyle.Default, handler: {
                (alertAction: UIAlertAction) -> () in
                var sourceType = UIImagePickerControllerSourceType.Camera
                if !UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera){
                    sourceType = UIImagePickerControllerSourceType.PhotoLibrary
                }
                let picker = UIImagePickerController()
                picker.delegate = self
                picker.allowsEditing = true
                picker.sourceType = sourceType
                self.presentViewController(picker, animated: true, completion: nil)
            })
            alertController.addAction(takeAction)
            let selectAction = UIAlertAction(title: "从相册选择", style: UIAlertActionStyle.Default, handler: {
                (alertAction: UIAlertAction) -> () in
                let pickerImage = UIImagePickerController()
                if !UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
                    pickerImage.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
                    pickerImage.mediaTypes = UIImagePickerController.availableMediaTypesForSourceType(pickerImage.sourceType)!
                }
                pickerImage.modalPresentationStyle = .Popover
                pickerImage.delegate = self
                pickerImage.allowsEditing = true
                let popOver = pickerImage.popoverPresentationController! as UIPopoverPresentationController
                popOver.sourceView = self.orderInfoView.carInfoView.uploadDrivingLicense
                popOver.sourceRect = self.orderInfoView.carInfoView.uploadDrivingLicense.bounds
                popOver.permittedArrowDirections = .Up
                self.presentViewController(pickerImage, animated: true, completion: nil)
            })
            alertController.addAction(selectAction)
        }
    }
    
    func uploadTyre() {
        resign()
        currentUploadObject = "tyre"
        let alertController = UIAlertController(title: "提示", message: "上传轮胎照片", preferredStyle: UIAlertControllerStyle.ActionSheet)
        alertController.modalPresentationStyle = .Popover
        let popOverController = alertController.popoverPresentationController! as UIPopoverPresentationController
        popOverController.sourceView = orderInfoView.carInfoView.uploadTyre
        popOverController.sourceRect = orderInfoView.carInfoView.uploadTyre.bounds
        popOverController.permittedArrowDirections = .Up
        self.presentViewController(alertController, animated: true) { () -> Void in
            let takeAction = UIAlertAction(title: "拍照", style: UIAlertActionStyle.Default, handler: {
                (alertAction: UIAlertAction) -> () in
                var sourceType = UIImagePickerControllerSourceType.Camera
                if !UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera){
                    sourceType = UIImagePickerControllerSourceType.PhotoLibrary
                }
                let picker = UIImagePickerController()
                picker.delegate = self
                picker.allowsEditing = true
                picker.sourceType = sourceType
                self.presentViewController(picker, animated: true, completion: nil)
            })
            alertController.addAction(takeAction)
            let selectAction = UIAlertAction(title: "从相册选择", style: UIAlertActionStyle.Default, handler: {
                (alertAction: UIAlertAction) -> () in
                let pickerImage = UIImagePickerController()
                if !UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
                    pickerImage.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
                    pickerImage.mediaTypes = UIImagePickerController.availableMediaTypesForSourceType(pickerImage.sourceType)!
                }
                pickerImage.modalPresentationStyle = .Popover
                pickerImage.delegate = self
                pickerImage.allowsEditing = true
                let popOver = pickerImage.popoverPresentationController! as UIPopoverPresentationController
                popOver.sourceView = self.orderInfoView.carInfoView.uploadTyre
                popOver.sourceRect = self.orderInfoView.carInfoView.uploadTyre.bounds
                popOver.permittedArrowDirections = .Up
                self.presentViewController(pickerImage, animated: true, completion: nil)
            })
            alertController.addAction(selectAction)
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        var img = info[UIImagePickerControllerEditedImage] as! UIImage
        if picker.sourceType == .Camera {
            let sizeChange = CGSize(width: 300,height: 300)
            UIGraphicsBeginImageContextWithOptions(sizeChange, false, 0.0)
            img.drawInRect(CGRect(origin: CGPointZero, size: sizeChange))
            img = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            img = UIImage(data: UIImageJPEGRepresentation(img, 0.1)!)!
        }
        if currentUploadObject == "tyre" {
            orderInfoView.carInfoView.uploadTyre.image = img
        }
        if currentUploadObject == "drivinglicense" {
            orderInfoView.carInfoView.uploadDrivingLicense.image = img
        }
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController){
        picker.dismissViewControllerAnimated(true, completion: nil)        
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        var dest = segue.destinationViewController as UIViewController
        if let destination = dest as? UINavigationController {
            dest = destination.visibleViewController!
        }
        if let result = dest as? OrderSucessViewController {
            result.orderId = orderId!
        }
    }

}
