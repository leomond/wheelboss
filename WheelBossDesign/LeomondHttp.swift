//
//  LeomondHttp.swift
//  WheelBossDesign
//
//  Created by 李秋声 on 16/3/6.
//  Copyright © 2016年 Leomond. All rights reserved.
//

import UIKit

@objc public protocol LeomondHttpDelegate: NSObjectProtocol {
    optional func willSendRequest(identifier: String, cover: UIActivityIndicatorView)
    optional func didResponse(identifier: String)
    optional func endedSendRequest(identifier: String, result: NSData)
    optional func endedSendRequestByJsonRespone(identifier: String, result: NSDictionary)
    optional func parseJsonResultError(identifier: String)
    func responseError(identifier: String)
    func networkUnavailable(identifier: String)
}

public class LeomondHttp: NSObject {
    
    var uri: String?
    var parameters: Dictionary<String, AnyObject>?
    var timeoutInterval: NSTimeInterval?
    var loadingTips: Bool = true
    var jsonResult: Bool = true
    let cover = UIActivityIndicatorView.init()
    var identifier: String?
    var viewController: UIViewController?
    var subView: UIView?
    
    weak public var delegate: LeomondHttpDelegate?
    
    init(identifier: String, uri: String, parameters: Dictionary<String, AnyObject>, loadingTips: Bool, viewController: UIViewController, subView: UIView) {
        self.identifier = identifier
        self.uri = uri
        self.parameters = parameters
        self.timeoutInterval = 5
        self.loadingTips = loadingTips
        self.viewController = viewController
        self.subView = subView
        if loadingTips {
            cover.center = (self.viewController?.view.center)!
            cover.hidesWhenStopped = true
            cover.activityIndicatorViewStyle = .WhiteLarge
        }
    }
    
    func sendPostRequest() {
        guard let reach = try? Reachability.reachabilityForInternetConnection() else {
            delegate?.networkUnavailable(identifier!)
            return
        }
        if !reach.isReachable() {
            delegate?.networkUnavailable(identifier!)
            return
        }
        
        delegate?.willSendRequest?(identifier!, cover: cover)
        
        if loadingTips {
            cover.hidden = false
            viewController?.view.addSubview(cover)
            cover.bringSubviewToFront(subView!)
            cover.startAnimating()
        }
        var bodyStr: String = ""
        for (key, value) in parameters! {
            if let stringValue = value as? String {
                bodyStr += key + "=" + stringValue + "&"
            } else if let dictValue = value as? NSDictionary {
                bodyStr += key + "=" + dictionaryToJson(dictValue) + "&"
            }
            
        }
        let length: Int = bodyStr.characters.count - 1
        bodyStr = (bodyStr as NSString).substringToIndex(length)
        print("body:\(bodyStr)")
        let url = NSURL(string: uri!)
        let request = NSMutableURLRequest(URL: url!, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringCacheData, timeoutInterval: timeoutInterval!)
        request.HTTPMethod = "POST"
        request.HTTPBody = bodyStr.dataUsingEncoding(NSUTF8StringEncoding)
        request.setValue("WheelBoss APP", forHTTPHeaderField: "User-Agent")
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue(), completionHandler: { (_, data, _) -> Void in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.delegate?.didResponse?(self.identifier!)
                if self.loadingTips {
                    self.cover.stopAnimating()
                    self.cover.removeFromSuperview()
                }
                if let result = data {
                    if self.jsonResult {
                        self.processJsonInfo(result)
                    } else {
                        self.delegate?.endedSendRequest?(self.identifier!, result: result)
                    }
                } else {
                    self.delegate?.responseError(self.identifier!)
                }
            })
        })
    }
    
    private func processJsonInfo(result: NSData) {
        print("result: \(String.init(data: result, encoding: NSUTF8StringEncoding))")
        guard let jsonObject : AnyObject! = try? NSJSONSerialization.JSONObjectWithData(result, options: NSJSONReadingOptions.MutableContainers) else {
            delegate?.parseJsonResultError?(identifier!)
            return
        }
        if let rstDictionary = jsonObject as? NSDictionary {
            delegate?.endedSendRequestByJsonRespone?(identifier!, result: rstDictionary)
        } else {
            delegate?.parseJsonResultError?(identifier!)
        }
    }
    
    private func dictionaryToJson(dict: NSDictionary) -> String {
        guard let data = try? NSJSONSerialization.dataWithJSONObject(dict, options: NSJSONWritingOptions.PrettyPrinted) else {
            return ""
        }
        let strJson=NSString(data: data, encoding: NSUTF8StringEncoding)
        return strJson as! String
    }

}
