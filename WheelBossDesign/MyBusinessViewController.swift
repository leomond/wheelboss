//
//  MyBusinessViewController.swift
//  WheelBossDesign
//
//  Created by 李秋声 on 16/2/8.
//  Copyright © 2016年 Leomond. All rights reserved.
//

import UIKit

class MyBusinessViewController: BaseWithBackViewController, MineLeftListViewDataSource, MyOrderHeadViewDataSource, MyOrderBodyScrollViewDataSource, LoginDialogDelegate, LeomondHttpDelegate, UIScrollViewDelegate, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var myBusiness: MyBusinessView! {
        didSet {
            myBusiness.leftView.leftList.dataSource = self
            myBusiness.rightView.myOrderView.titleView.dataSource = self
            myBusiness.rightView.myOrderView.bodyView.dataSource = self
            myBusiness.rightView.myOrderView.bodyView.delegate = self
            
            myBusiness.rightView.myInfo.pwdModify.originalPwd.delegate = self
            myBusiness.rightView.myInfo.pwdModify.newPwd.delegate = self
            myBusiness.rightView.myInfo.pwdModify.repeatPwd.delegate = self
            
            myBusiness.rightView.myInfo.pwdModify.confirm.addTarget(self, action: "modifyPwd", forControlEvents: .TouchUpInside)
            
            myBusiness.rightView.myInfo.myBaseInfo.uploadAvatar.upload.addTarget(self, action: "uploadAvatar", forControlEvents: .TouchUpInside)
        }
    }
    
    var storeInfo: Dictionary<String, AnyObject>?
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    var orderInfo: MyOrderInfoCell?
    
    var refreshControl: UIRefreshControl?
    
    var loadingTips: Bool = true
    
    var page: Int = 1
    
    var totaldata: Int = 0
    
    var refreshing: Bool = false {
        didSet {
            loadingTips = !refreshing
            page = 1
            if (self.refreshing) {
                self.refreshControl?.beginRefreshing()
            }
            else {
                self.refreshControl?.endRefreshing()
            }
        }
    }
    
    let loadingHeight: CGFloat = 100
    
    let activityViewIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
    
    var pullUp: Bool = false {
        didSet {
            loadingTips = !pullUp
            if pullUp && myBusiness.rightView.myOrderView.orderList.count < totaldata {
                page += 1
            }
        }
    }
    
    var currentOpreation: String = ""
    
    private var keyboardHeight: CGFloat = 400
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myBusiness.rightView.myInfo.myBaseInfo.uploadAvatar.avatar.image = myBusiness.leftView.storeImage.image
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillAppear:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardDidHide:", name: UIKeyboardDidHideNotification, object: nil)
        
        storeInfo = defaults.objectForKey(MyBusinessInfo.StoreInfoIdentifier) as? Dictionary<String, AnyObject>
        loadStoreInfo()
        loadOrderInfo()
        
        //添加下拉刷新
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: "onPullToFresh", forControlEvents: UIControlEvents.ValueChanged)
        self.myBusiness.rightView.myOrderView.bodyView.addSubview(refreshControl!)

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
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        UIView.animateWithDuration(0.4) { () -> Void in
            let distance: CGFloat = self.calculateDistanceToTheBottom()
            let viewY: CGFloat = distance - self.keyboardHeight
            self.view.frame.origin.y = min(viewY, 0)
        }
        return true
    }
    
    func calculateDistanceToTheBottom() -> CGFloat {
        let paddingTop = myBusiness.frame.origin.y + myBusiness.rightView.myInfo.space * 2 + myBusiness.rightView.myInfo.titleViewHeight + myBusiness.rightView.myInfo.pwdModify.topSpace + myBusiness.rightView.myInfo.pwdModify.componemtSpace * 3 + myBusiness.rightView.myInfo.pwdModify.height * 4
        return view.bounds.size.height - paddingTop
    }
    
    func onPullToFresh() {
        refreshing = true
        loadOrderInfo()
    }
    
    func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if scrollView.contentOffset.y + scrollView.bounds.size.height - loadingHeight >= scrollView.contentSize.height {
            if myBusiness.rightView.myOrderView.orderList.count < totaldata {
                let y = scrollView.contentSize.height + loadingHeight / 2 - activityViewIndicator.bounds.height / 2
                activityViewIndicator.frame = CGRectMake((scrollView.bounds.size.width - activityViewIndicator.bounds.width) / 2, y, activityViewIndicator.bounds.width, activityViewIndicator.bounds.height)
                activityViewIndicator.color = UIColor.grayColor()
                activityViewIndicator.startAnimating()
                activityViewIndicator.hidesWhenStopped = true
                activityViewIndicator.hidden = false
                scrollView.addSubview(activityViewIndicator)
                scrollView.contentSize = CGSize(width: scrollView.bounds.size.width, height: loadingHeight + scrollView.contentSize.height)
                pullUp = true
                loadOrderInfo()
            }
        }
    }
    
    func loadOrderInfo() {
        let info = self.defaults.objectForKey(SignInConstants.LoginStateMark)
        if let tokenInfo = info as? Dictionary<String, String> {
            if let loginInfo = tokenInfo["accesstoken"] {
                let token = loginInfo as String
                var parameters = [
                    "accesstoken": token,
                    "page": "\(page)",
                    "rowcount": "10"
                ]
                let focusButton = myBusiness.rightView.myOrderView.titleView.focusButton
                switch focusButton {
                case "待确认":
                    parameters["status"] = "00"
                    break
                case "待收货":
                    parameters["status"] = "03"
                    break
                case "待安装":
                    parameters["status"] = "04"
                    break
                default:
                    break
                }
                let reqHttp = LeomondHttp.init(identifier: "gerOrderInfo", uri: URIConstants.OrderInfoList, parameters: parameters, loadingTips: loadingTips, viewController: self, subView: myBusiness.rightView.myOrderView)
                currentOpreation = "gerOrderInfo"
                reqHttp.delegate = self
                reqHttp.sendPostRequest()
            }
        }
    }
    
    func loginDialogSuccessLogin() {
        loadStoreInfo()
        let selectedMenu = myBusiness.leftView.leftList.selectedMenu
        switch selectedMenu {
        case "myOrder":
            switch currentOpreation {
            case "gerOrderInfo":
                loadOrderInfo()
                break
            case "orderOpreation":
                opreateOrderState()
                break
            default:
                break
            }
            break
        case "myInfo":
            modifyPwd()
            break
        default:
            break
        }
        
    }
    
    func getMyOrderInfoCell(ordefInfo: Dictionary<String, AnyObject>) -> MyOrderInfoCell {
        var cell = MyOrderInfoCell()
        cell.orderNumber = ordefInfo["orderno"] as? String ?? ""
        cell.orderTime = ordefInfo["createtime"] as? String ?? ""
        if let serisename = ordefInfo["wheelseriesname"] as? String {
            cell.productSeries = serisename
        }
        if let wheeltype = ordefInfo["wheeltype"] as? String {
            cell.productModel = "CGCG\(wheeltype)"
        }
        let carownername = ordefInfo["carownername"] as? String ?? ""
        let vehiclebrand = ordefInfo["vehiclebrand"] as? String ?? ""
        cell.custInfo = carownername + "，" + vehiclebrand
        cell.phone = ordefInfo["carowertel"] as? String ?? ""
        cell.orderState = ordefInfo["state"] as? String ?? ""
        cell.wheelpic = ordefInfo["wheelpic"] as? String ?? ""
//        if let lf = ordefInfo["rimpicid"] as? String {
//            cell.productPicture.lf = lf
//        }
//        if let lw = ordefInfo["spokepicid"] as? String {
//            cell.productPicture.lw = lw
//        }
//        if let ly = ordefInfo["flangepicid"] as? String {
//            cell.productPicture.ly = ly
//        }
        return cell
    }
    
    func loadStoreInfo() {
        let info = defaults.objectForKey(SignInConstants.LoginStateMark)
        if let tokenInfo = info as? Dictionary<String, String> {
            if let loginInfo = tokenInfo["accesstoken"] {
                let token = loginInfo as String
                let parameters = [
                    "accesstoken": token
                ]
                let reqHttp = LeomondHttp.init(identifier: "getStoreInfo", uri: URIConstants.QueryStoreInfo, parameters: parameters, loadingTips: false, viewController: self, subView: view)
                reqHttp.delegate = self
                reqHttp.sendPostRequest()
            }
        }
    }
    
    func networkUnavailable(identifier: String) {
        switch identifier {
        case "gerOrderInfo":
            break
        default:
            break
        }
    }
    
    func responseError(identifier: String) {
        
    }
    
    func willSendRequest(identifier: String, cover: UIActivityIndicatorView) {
        switch identifier {
        case "gerOrderInfo", "orderOpreation", "modifyPwd":
            cover.center = CGPointMake(view.bounds.size.width * (1 + myBusiness.leftRatio) / 2, view.center.y)
            cover.color = UIColor.grayColor()
            break
        default:
            break
        }
    }
    
    func endedSendRequestByJsonRespone(identifier: String, result: NSDictionary) {
        switch identifier {
        case "getStoreInfo":
            processStoreInfo(result)
            break
        case "gerOrderInfo":
            if refreshing {
                refreshing = false
            }
            if pullUp {
                pullUp = false
                activityViewIndicator.stopAnimating()
                activityViewIndicator.removeFromSuperview()
            }
            processOrderInfo(result)
            break
        case "orderOpreation":
            processOrderOpreation(result)
            break
        case "modifyPwd":
            processModifyPwd(result)
            break
        case "uploadAvatar":
            processUploadAvatar(result)
            break
        default:
            break
        }
    }
    
    func processModifyPwd(result: NSDictionary) {
        let rspCode: NSString = result.objectForKey("code") as! NSString
        if rspCode == "0000" {
            showAlert("提示", message: "密码修改成功")
            myBusiness.rightView.myInfo.pwdModify.originalPwd.text = ""
            myBusiness.rightView.myInfo.pwdModify.newPwd.text = ""
            myBusiness.rightView.myInfo.pwdModify.repeatPwd.text = ""
        } else {
            showAlert(result.objectForKey("message") as! String)
        }
    }
    
    func processOrderOpreation(result: NSDictionary) {
        let rspCode: NSString = result.objectForKey("code") as! NSString
        if rspCode == "0000" {
            loadOrderInfo()
        } else if rspCode == "1004" {
            let signUp = LoginDialog.init(viewController: self, subView: myBusiness)
            signUp.delgate = self
            signUp.showLoginDialog()
        } else {
            showAlert(result.objectForKey("message") as! String)
        }
    }
    
    private func showAlert(message: String) {
        showAlert("错误提示", message: message)
    }
    
    private func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "确定", style: UIAlertActionStyle.Default, handler: nil)
        alertController.addAction(okAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func processStoreInfo(result: NSDictionary) {
//        let data = try! NSJSONSerialization.dataWithJSONObject(result, options: NSJSONWritingOptions.PrettyPrinted)
//        let strJson=NSString(data: data, encoding: NSUTF8StringEncoding)
//        print("json:\(strJson)")
        let rspCode: NSString = result.objectForKey("code") as! NSString
        if rspCode == "0000" {
            if let storeinfo = result.objectForKey("storeinfo") as? Dictionary<String, AnyObject> {
                if let storename = storeinfo["storename"] as? String {
                    myBusiness.leftView.storeName = storename
                }
                storeInfo = storeinfo
                storeInfo!["token"] = result
                setMyInfo()
            }
        }
    }
    
    func setMyInfo() {
        if let storename = storeInfo?["storename"] as? String {
            myBusiness.rightView.myInfo.myBaseInfo.storeNameValue.text = storename
        }
        if let staffid = storeInfo?["staffid"] as? String {
            myBusiness.rightView.myInfo.myBaseInfo.staffIdValue.text = staffid
        }
        if let storecontact = storeInfo?["storecontact"] as? String {
            myBusiness.rightView.myInfo.myBaseInfo.contactPersonValue.text = storecontact
        }
        if let storetel = storeInfo?["storetel"] as? String {
            myBusiness.rightView.myInfo.myBaseInfo.phoneValue.text = storetel
        }
        if let storemailbox = storeInfo?["storemailbox"] as? String {
            myBusiness.rightView.myInfo.myBaseInfo.emailvalue.text = storemailbox
        }
        if let wechat = storeInfo?["wechat"] as? String {
            myBusiness.rightView.myInfo.myBaseInfo.wechatValue.text = wechat
        }
        if let storeaddr = storeInfo?["storeaddr"] as? String {
            myBusiness.rightView.myInfo.myBaseInfo.storeAddressValue.text = storeaddr
        }
        if let storedispic = storeInfo?["storedispic"] as? String {
            let imgURL:NSURL=NSURL(string: storedispic)!
            let request:NSURLRequest=NSURLRequest(URL:imgURL)
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(),
                completionHandler: {(response, data, error)->Void in
                    let img=UIImage(data:data!)
                    self.myBusiness.leftView.storeImage.image = img
            })
        }
    }
    
    func processOrderInfo(result: NSDictionary) {
        let data = try! NSJSONSerialization.dataWithJSONObject(result, options: NSJSONWritingOptions.PrettyPrinted)
        let strJson=NSString(data: data, encoding: NSUTF8StringEncoding)
        print("json:\(strJson)")
        let rspCode: NSString = result.objectForKey("code") as! NSString
        if rspCode == "0000" {
            if let items = result.objectForKey("orderlist") as? [Dictionary<String, AnyObject>] {
                var tmp: [MyOrderInfoCell] = [MyOrderInfoCell]()
                for ordefInfo in items {
                    let cell = getMyOrderInfoCell(ordefInfo)
                    tmp += [cell]
                }
                if page > 1 {
                    myBusiness.rightView.myOrderView.orderList += tmp
                } else {
                    totaldata = (result.objectForKey("count") as! NSString).integerValue
                    myBusiness.rightView.myOrderView.orderList = tmp
                    myBusiness.rightView.myOrderView.bodyView.contentOffset = CGPointZero
                }
                return
            }
        } else if rspCode == "1004" {
            let signUp = LoginDialog.init(viewController: self, subView: myBusiness)
            signUp.delgate = self
            signUp.showLoginDialog()
            return
        }
        myBusiness.rightView.myOrderView.orderList = [MyOrderInfoCell]()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func back() {
        let story = UIStoryboard(name: "Main", bundle: nil)
        let vc = story.instantiateViewControllerWithIdentifier("home") as! UINavigationController
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    func doClickListViewCell(identifier: String) {
        switch identifier {
        case "logOut":
            // do log out
            showLogoutDialog()
            break
        default:
            myBusiness.rightView.identifier = identifier
            if identifier == "myInfo" {
                myBusiness.rightView.myInfo.myBaseInfo.uploadAvatar.avatar.image = myBusiness.leftView.storeImage.image
            }
            break
        }
        
    }
    
    func showLogoutDialog() {
        let alertController = UIAlertController(title: "退出", message: "您确定退出当前账号？", preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "确定", style: UIAlertActionStyle.Default, handler:  {
            (alertAction: UIAlertAction) -> () in
            
            let info = self.defaults.objectForKey(SignInConstants.LoginStateMark)
            self.defaults.removeObjectForKey(SignInConstants.LoginStateMark)
            if let tokenInfo = info as? Dictionary<String, String> {
                if let loginInfo = tokenInfo["accesstoken"] {
                    let token = loginInfo as String
                    let parameters = [
                        "accesstoken": token
                    ]
                    var bodyStr: String = ""
                    for (key, value) in parameters {
                        bodyStr += key + "=" + value + "&"
                    }
                    let length: Int = bodyStr.characters.count - 1
                    bodyStr = (bodyStr as NSString).substringToIndex(length)
                    let session = NSURLSession.sharedSession()
                    let urlstr = URIConstants.LogOutURI
                    let url = NSURL(string: urlstr)
                    let request = NSMutableURLRequest(URL: url!, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringCacheData, timeoutInterval: 5)
                    request.HTTPMethod = "POST"
                    request.HTTPBody = bodyStr.dataUsingEncoding(NSUTF8StringEncoding)
                    request.setValue("WheelBoss APP", forHTTPHeaderField: "User-Agent")
                    
                    let semaphore = dispatch_semaphore_create(0)
                    let dataTask = session.dataTaskWithRequest(request,
                        completionHandler: {(data, response, error) -> Void in
                            if error != nil{
                                print(error?.code)
                                print(error?.description)
                            }else{
                                var result: NSData = NSData()
                                result = data!
                                let str = NSString.init(data: result, encoding: NSUTF8StringEncoding)
                                print("result: \(str)")
                            }
                            
                            dispatch_semaphore_signal(semaphore)
                    }) as NSURLSessionTask
                    
                    dataTask.resume()
                }
            }
            let story = UIStoryboard(name: "Main", bundle: nil)
            let vc = story.instantiateViewControllerWithIdentifier("signUp")
            self.presentViewController(vc, animated: true, completion: nil)
        })
        alertController.addAction(okAction)
        let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler:  {
            (alertAction: UIAlertAction) -> () in
            self.myBusiness.leftView.leftList.selectedMenu = self.myBusiness.leftView.leftList.lastSelectedMenu
        })
        alertController.addAction(cancelAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func clickHeadState(state: String) {
        loadOrderInfo()
    }
    
    func showMoreOrderInfo(orderInfo: MyOrderInfoCell) {
        self.orderInfo = orderInfo
        self.performSegueWithIdentifier("showOrderDetail", sender: self)
    }
    
    func doOrderNoticeAction(orderInfo: MyOrderInfoCell) {
        print("doOrderNoticeAction id: \(orderInfo.orderNumber) \(orderInfo.orderState)")
        self.orderInfo = orderInfo
        switch orderInfo.orderState {
        case "待确认":
            showTwoConfirmationDialog("您确定要取消该订单？")
            break
        case "待收货":
            showTwoConfirmationDialog("您确定该订单已收货？")
            break
        case "待安装":
            showTwoConfirmationDialog("您确定该订单已完成安装？")
            break
        default:
            break
        }
    }
    
    func showTwoConfirmationDialog(message: String) {
        let alertController = UIAlertController(title: "提示", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "确定", style: UIAlertActionStyle.Default, handler:  {
            (alertAction: UIAlertAction) -> () in
            self.opreateOrderState()
        })
        alertController.addAction(okAction)
        let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler:  nil)
        alertController.addAction(cancelAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func opreateOrderState() {
        let info = self.defaults.objectForKey(SignInConstants.LoginStateMark)
        if let tokenInfo = info as? Dictionary<String, String> {
            if let loginInfo = tokenInfo["accesstoken"] {
                let token = loginInfo as String
                let parameters = [
                    "accesstoken": token,
                    "orderno": orderInfo?.orderNumber ?? "",
                    "oldorderstatus": getOrderStateId((orderInfo?.orderState)!),
                    "neworderstatus": getOrderChangerStateId((orderInfo?.orderState)!)
                ]
                let reqHttp = LeomondHttp.init(identifier: "orderOpreation", uri: URIConstants.OrderOpereation, parameters: parameters, loadingTips: true, viewController: self, subView: myBusiness.rightView.myOrderView)
                currentOpreation = "orderOpreation"
                reqHttp.delegate = self
                reqHttp.sendPostRequest()
            }
        }
    }
    
    func getOrderStateId(state: String) -> String {
        switch state {
        case "待确认":
            return "00"
        case "待收货":
            return "03"
        case "待安装":
            return "04"
        default:
            return ""
        }
    }
    
    func getOrderChangerStateId(state: String) -> String {
        switch state {
        case "待确认":
            return "99"
        case "待收货":
            return "04"
        case "待安装":
            return "05"
        default:
            return ""
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        resign()
    }
    
    func resign() {
        if myBusiness.rightView.myInfo.pwdModify.newPwd.isFirstResponder() {
            myBusiness.rightView.myInfo.pwdModify.newPwd.resignFirstResponder()
        }
        if myBusiness.rightView.myInfo.pwdModify.originalPwd.isFirstResponder() {
            myBusiness.rightView.myInfo.pwdModify.originalPwd.resignFirstResponder()
        }
        if myBusiness.rightView.myInfo.pwdModify.repeatPwd.isFirstResponder() {
            myBusiness.rightView.myInfo.pwdModify.repeatPwd.resignFirstResponder()
        }
        self.view.becomeFirstResponder()
        UIView.animateWithDuration(0.2, animations: {
            self.view.frame.origin.y = 0
        })
    }
    
    func modifyPwd() {
        resign()
        let originalPwd = myBusiness.rightView.myInfo.pwdModify.originalPwd.text
        if originalPwd == "" {
            showAlert("请输入原始密码！")
            return
        }
        let newPwd = myBusiness.rightView.myInfo.pwdModify.newPwd.text
        if newPwd == "" {
            showAlert("请输入新密码！")
            return
        }
        let repeatPwd = myBusiness.rightView.myInfo.pwdModify.repeatPwd.text
        if repeatPwd == "" {
            showAlert("请重复输入新密码！")
            return
        }
        if originalPwd == newPwd {
            showAlert("新密码必须与原密码不一致！")
            return
        }
        if newPwd != repeatPwd {
            showAlert("您两次输入的密码不一致！")
            return
        }
        let defaults = NSUserDefaults.standardUserDefaults()
        let info = defaults.objectForKey(SignInConstants.LoginStateMark)
        if let tokenInfo = info as? Dictionary<String, String> {
            if let loginInfo = tokenInfo["accesstoken"] {
                
                let token = loginInfo as String
                let parameters = [
                    "accesstoken": token,
                    "oldpasswd": originalPwd!,
                    "newpasswd": newPwd!
                ]
                let reqHttp = LeomondHttp.init(identifier: "modifyPwd", uri: URIConstants.PwdModify, parameters: parameters, loadingTips: true, viewController: self, subView: myBusiness.rightView.myInfo)
                currentOpreation = "modifyPwd"
                reqHttp.delegate = self
                reqHttp.sendPostRequest()
            }
        }
    }
    
    func uploadAvatar() {
        let alertController = UIAlertController(title: "提示", message: "上传门店照片", preferredStyle: UIAlertControllerStyle.ActionSheet)
        alertController.modalPresentationStyle = .Popover
        let popOverController = alertController.popoverPresentationController! as UIPopoverPresentationController
        popOverController.sourceView = myBusiness.rightView.myInfo.myBaseInfo.uploadAvatar.upload
        popOverController.sourceRect = myBusiness.rightView.myInfo.myBaseInfo.uploadAvatar.upload.bounds
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
                popOver.sourceView = self.myBusiness.rightView.myInfo.myBaseInfo.uploadAvatar.upload
                popOver.sourceRect = self.myBusiness.rightView.myInfo.myBaseInfo.uploadAvatar.upload.bounds
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
        myBusiness.leftView.storeImage.image = img
        myBusiness.rightView.myInfo.myBaseInfo.uploadAvatar.avatar.image = img
        picker.dismissViewControllerAnimated(true, completion: nil)
        postAvatar()
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController){
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func postAvatar() {
        if let avatar = myBusiness.rightView.myInfo.myBaseInfo.uploadAvatar.avatar.image {
            let defaults = NSUserDefaults.standardUserDefaults()
            let info = defaults.objectForKey(SignInConstants.LoginStateMark)
            if let tokenInfo = info as? Dictionary<String, String> {
                if let loginInfo = tokenInfo["accesstoken"] {
                    
                    let token = loginInfo as String
                    let parameters = [
                        "accesstoken": token,
                        "pic": (UIImageJPEGRepresentation(avatar, 0.5)?.base64EncodedStringWithOptions(.EncodingEndLineWithLineFeed))!
                    ]
                    let reqHttp = LeomondHttp.init(identifier: "uploadAvatar", uri: URIConstants.UploadAvatar, parameters: parameters, loadingTips: true, viewController: self, subView: myBusiness.rightView.myInfo)
                    currentOpreation = "uploadAvatar"
                    reqHttp.delegate = self
                    reqHttp.sendPostRequest()
                }
            }
        }
        
    }
    
    func processUploadAvatar(result: NSDictionary) {
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
        if let identifier = segue.identifier {
            switch identifier {
            case "showOrderDetail":
                if let result = dest as? OrderDetailViewController {
                    result.orderInfo = orderInfo
                }
                break
            default:
                break
            }
        }
    }

}
