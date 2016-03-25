//
//  SignInViewController.swift
//  design
//
//  Created by 李秋声 on 16/1/17.
//  Copyright © 2016年 Leomond. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController, UITextFieldDelegate, LeomondHttpDelegate {
    
    @IBOutlet weak var loginbtn: CustomUIButton!
    @IBOutlet weak var userName: LoginComponentUIView!
    @IBOutlet weak var userPwd: LoginComponentUIView!
    @IBOutlet weak var placeholderView: UIView!
    
    private var keyboardHeight: CGFloat = 400
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
//    var alert = AnnouncementViewController()
    
    private struct Constants {
        static let pleaseInputUserName: String = "请输入用户名"
        static let pleaseInputUserPwd: String = "请输入密码"
        static let messageTitle: String = "错误提示"
        static let okButtonTitle: String = "确定"
        
        static let fixedKeyBoardHeight: CGFloat = 18
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userName.textField.delegate = self
        userPwd.textField.delegate = self
        
        let info = defaults.objectForKey(SignInConstants.LoginStateMark)
        if let tokenInfo = info as? Dictionary<String, String> {
            if let token = tokenInfo["accesstoken"] {
                let parameters = [
                    "accesstoken": token
                ]
                
                let httpReq = LeomondHttp.init(identifier: "validAccesstoken", uri: URIConstants.ValidAccessToken, parameters: parameters, loadingTips: true, viewController: self, subView: self.view)
                httpReq.delegate = self
                httpReq.sendPostRequest()
            }
        } else {
            baseSettings()
        }
        
        // Do any additional setup after loading the view.
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func baseSettings() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillAppear:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardDidHide:", name: UIKeyboardDidHideNotification, object: nil)
        
        userName.textField.becomeFirstResponder()
    }
    
    func stepHome() {
        self.performSegueWithIdentifier("showHome", sender: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func keyboardWillAppear(notification: NSNotification) {
        let keyboardinfo = notification.userInfo![UIKeyboardFrameBeginUserInfoKey]
        keyboardHeight = (keyboardinfo?.CGRectValue.size.height)!
    }
    
    func keyboardDidHide(notification: NSNotification) {
        resign()
    }
    
    func textFieldShouldClear(textField: UITextField) -> Bool {
        if textField == userName.textField {
            userPwd.textField.text = ""
        }
        return true
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        UIView.animateWithDuration(0.4) { () -> Void in
            let distance: CGFloat = self.calculateDistanceToTheBottom()
            let viewY: CGFloat = distance - self.keyboardHeight - Constants.fixedKeyBoardHeight
            self.view.frame.origin.y = min(viewY, 0)
        }
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField.returnKeyType == UIReturnKeyType.Next {
            userPwd.textField.becomeFirstResponder()
        }
        if textField.returnKeyType == UIReturnKeyType.Go {
            login(UIButton())
        }
        return true
    }
    
    private func calculateDistanceToTheBottom() -> CGFloat {
        let height: CGFloat = self.view.bounds.size.height / 2
        return height - userPwd.bounds.size.height / 2 - loginbtn.bounds.size.height - placeholderView.bounds.size.height
    }
    
    func tapOnce(){
        UIView.animateWithDuration(0.2, animations: {
            self.view.frame.origin.y = 0
        })
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        resign()
    }
    
    private func resign() {
        if userName.textField.isFirstResponder() {
            userName.textField.resignFirstResponder()
        }
        if userPwd.textField.isFirstResponder() {
            userPwd.textField.resignFirstResponder()
        }
        self.view.becomeFirstResponder()
        tapOnce()
    }

    @IBAction func login(sender: UIButton) {
        resign()
        
        let userNameValue: String = userName.textField.text!
        if userNameValue == "" {
            showAlert(Constants.pleaseInputUserName)
            return
        }
        let userPwdValue: String = userPwd.textField.text!
        if userPwdValue == "" {
            showAlert(Constants.pleaseInputUserPwd)
            return
        }
        
        let parameters = [
            "username": userNameValue,
            "passwd": userPwdValue
        ]
        
        let httpReq = LeomondHttp.init(identifier: "signup", uri: URIConstants.LoginURI, parameters: parameters, loadingTips: true, viewController: self, subView: self.view)
        httpReq.delegate = self
        httpReq.sendPostRequest()
    }
    
    func networkUnavailable(identifier: String) {
        showAlert("您的网络当前不可用，请检查您的网络设置！")
        if identifier == "validAccesstoken" {
            baseSettings()
        }
    }
    
    func responseError(identifier: String) {
        showAlert("系统错误！")
        if identifier == "validAccesstoken" {
            baseSettings()
        }
    }
    
    func parseJsonResultError(identifier: String) {
        showAlert("返回参数解析异常！")
        if identifier == "validAccesstoken" {
            baseSettings()
        }
    }
    
    func endedSendRequestByJsonRespone(identifier: String, result: NSDictionary) {
        let rspCode: NSString = result.objectForKey("code") as! NSString
        switch identifier {
        case "signup":
            if rspCode == "0000" {
                defaults.setObject(CommonConstants.DefaultButtonOrder, forKey: CommonConstants.ButtonOrder)
                let token: NSString = result.objectForKey("accesstoken") as! String
                let staffid: NSString = result.objectForKey("staffid") as! String
                let tokenInfo = ["accesstoken": token, "staffid": staffid]
                defaults.setObject(tokenInfo, forKey: SignInConstants.LoginStateMark)
                stepHome()
            } else {
                let message: NSString = result.objectForKey("message") as! String
                showAlert(message as String)
                return
            }
            break
        case "validAccesstoken":
            if rspCode == "0000" {
                self.performSelector("stepHome", withObject: nil, afterDelay: 0)
            } else {
                baseSettings()
            }
            break
        default:
            break
        }
    }
    
    private func showAlert(message: String) {
        let alertController = UIAlertController(title: Constants.messageTitle, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: Constants.okButtonTitle, style: UIAlertActionStyle.Default, handler: {
            (alertAction: UIAlertAction) -> () in
            if message == Constants.pleaseInputUserName {
                self.userName.textField.becomeFirstResponder()
            }
            if message == Constants.pleaseInputUserPwd {
                self.userPwd.textField.becomeFirstResponder()
            }
        })
        alertController.addAction(okAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
