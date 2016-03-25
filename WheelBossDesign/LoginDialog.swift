//
//  LoginDialog.swift
//  WheelBossDesign
//
//  Created by 李秋声 on 16/3/5.
//  Copyright © 2016年 Leomond. All rights reserved.
//

import UIKit

@objc public protocol LoginDialogDelegate: NSObjectProtocol {
    optional func loginDialogSuccessLogin()
}

public class LoginDialog: NSObject {
    let defaults = NSUserDefaults.standardUserDefaults()
    var viewController: UIViewController?
    var subView: UIView?
    
    weak public var delgate: LoginDialogDelegate?
    
    init(viewController: UIViewController, subView: UIView) {
        self.viewController = viewController
        self.subView = subView
    }
    
    func showLoginDialog() {
        let info = self.defaults.objectForKey(SignInConstants.LoginStateMark)
        var message = "请输入账号密码"
        var staffid = ""
        if let tokenInfo = info as? Dictionary<String, String> {
            staffid = tokenInfo["staffid"]!
            message = "请输入账号[\(staffid)]的密码："
        }
        let alertController = UIAlertController(title: "登录", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        if staffid == "" {
            alertController.addTextFieldWithConfigurationHandler { (textField: UITextField!) -> Void in
                textField.placeholder = "用户名"
                textField.keyboardType = .ASCIICapable
            }
        }
        
        alertController.addTextFieldWithConfigurationHandler { (textField: UITextField!) -> Void in
            textField.placeholder = "密码"
            textField.secureTextEntry = true
        }
        let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler:  {
            (alertAction: UIAlertAction) -> () in
            self.defaults.removeObjectForKey(SignInConstants.LoginStateMark)
            let story = UIStoryboard(name: "Main", bundle: nil)
            let vc = story.instantiateViewControllerWithIdentifier("signUp")
            self.viewController!.presentViewController(vc, animated: true, completion: nil)
        })
        alertController.addAction(cancelAction)
        let okAction = UIAlertAction(title: "登录", style: UIAlertActionStyle.Default, handler:  {
            (alertAction: UIAlertAction) -> () in
            if staffid == "" {
                let username = (alertController.textFields?.first)! as UITextField
                staffid = username.text ?? ""
            }
            let password = (alertController.textFields?.last)! as UITextField
            if staffid == "" {
                self.showAlert("请输入用户名!")
                return
            }
            if password.text == "" {
                self.showAlert("您必须输入密码!")
                return
            }
            let cover = UIActivityIndicatorView.init(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
            cover.center = self.viewController!.view.center
            cover.hidesWhenStopped = true
            cover.color = UIColor.grayColor()
            self.viewController!.view.addSubview(cover)
            cover.bringSubviewToFront(self.subView!)
            cover.hidden = false
            cover.startAnimating()
            let parameters = [
                "username": staffid,
                "passwd": password.text
            ]
            var bodyStr: String = ""
            for (key, value) in parameters {
                bodyStr += key + "=" + value! + "&"
            }
            let length: Int = bodyStr.characters.count - 1
            bodyStr = (bodyStr as NSString).substringToIndex(length)
            
            //        let session = NSURLSession.sharedSession()
            let urlstr = URIConstants.LoginURI
            let url = NSURL(string: urlstr)
            let request = NSMutableURLRequest(URL: url!, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringCacheData, timeoutInterval: 5)
            request.HTTPMethod = "POST"
            request.HTTPBody = bodyStr.dataUsingEncoding(NSUTF8StringEncoding)
            request.setValue("WheelBoss APP", forHTTPHeaderField: "User-Agent")
            
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue(), completionHandler: { (_, data, _) -> Void in
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    cover.stopAnimating()
                    cover.removeFromSuperview()
                    if let result = data {
                        self.processJsonInfo(result)
                    }
                    
                })
            })
        })
        alertController.addAction(okAction)
        
        viewController!.presentViewController(alertController, animated: true, completion: nil)
    }
    
    private func processJsonInfo(result: NSData) {
        do {
            let jsonObject : AnyObject! = try NSJSONSerialization.JSONObjectWithData(result, options: NSJSONReadingOptions.MutableContainers)
            if let rstDictionary = jsonObject as? NSDictionary{
                let rspCode: NSString = rstDictionary.objectForKey("code") as! NSString
                if rspCode == "0000" {
                    defaults.setObject(CommonConstants.DefaultButtonOrder, forKey: CommonConstants.ButtonOrder)
                    let token: NSString = rstDictionary.objectForKey("accesstoken") as! String
                    let staffid: NSString = rstDictionary.objectForKey("staffid") as! String
                    let tokenInfo = ["accesstoken": token, "staffid": staffid]
                    defaults.setObject(tokenInfo, forKey: SignInConstants.LoginStateMark)
                    delgate?.loginDialogSuccessLogin?()
                } else {
                    let message: NSString = rstDictionary.objectForKey("message") as! String
                    showAlert(message as String)
                    return
                }
                
            }
        }catch let error as NSError{
            //打印错误消息
            print(error.code)
            print(error.description)
            showAlert("系统错误")
            return
        }
    }
    
    private func showAlert(message: String) {
        let alertController = UIAlertController(title: "提示", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let tryAgainAction = UIAlertAction(title: "重试一次", style: UIAlertActionStyle.Default, handler: {
            (alertAction: UIAlertAction) -> () in
            self.showLoginDialog()
        })
        alertController.addAction(tryAgainAction)
        let cancleAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Default, handler: {
            (alertAction: UIAlertAction) -> () in
            self.defaults.removeObjectForKey(SignInConstants.LoginStateMark)
            let story = UIStoryboard(name: "Main", bundle: nil)
            let vc = story.instantiateViewControllerWithIdentifier("signUp")
            self.viewController!.presentViewController(vc, animated: true, completion: nil)
        })
        alertController.addAction(cancleAction)
        viewController!.presentViewController(alertController, animated: true, completion: nil)
    }
}
