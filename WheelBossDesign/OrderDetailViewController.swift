//
//  OrderDetailViewController.swift
//  WheelBossDesign
//
//  Created by 李秋声 on 16/2/23.
//  Copyright © 2016年 Leomond. All rights reserved.
//

import UIKit

class OrderDetailViewController: BaseWithBackViewController, LoginDialogDelegate, LeomondHttpDelegate {

    @IBOutlet weak var bodyView: OrderDetailScrollView!
    
    var orderInfo: MyOrderInfoCell?
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        bodyView.orderInfoView.orderIdValue.text = orderInfo?.orderNumber
        bodyView.orderInfoView.orderStateValue.text = orderInfo?.orderState
        bodyView.orderInfoView.orderTimeValue.text = orderInfo?.orderTime
        
        bodyView.productInfoView.wheelTypeValue.text = orderInfo?.productSeries
        bodyView.productInfoView.wheelModelValue.text = orderInfo?.productModel
        
//        bodyView.productInfoView.wheelImage.lf.image = UIImage(named: (orderInfo?.productPicture.lf)!)
//        bodyView.productInfoView.wheelImage.lw.image = UIImage(named: (orderInfo?.productPicture.lw)!)
//        bodyView.productInfoView.wheelImage.ly.image = UIImage(named: (orderInfo?.productPicture.ly)!)
        
        bodyView.custInfoView.phoneValue.text = orderInfo?.phone
        
        loadOrderDetail()
        // Do any additional setup after loading the view.
    }
    
    func loadOrderDetail() {
        let info = self.defaults.objectForKey(SignInConstants.LoginStateMark)
        if let tokenInfo = info as? Dictionary<String, String> {
            if let loginInfo = tokenInfo["accesstoken"] {
                
                let token = loginInfo as String
                let parameters = [
                    "accesstoken": token,
                    "orderno": orderInfo?.orderNumber ?? ""
                ]
                let reqHttp = LeomondHttp.init(identifier: "orderDetail", uri: URIConstants.OrderDetailInfo, parameters: parameters, loadingTips: true, viewController: self, subView: bodyView)
                reqHttp.delegate = self
                reqHttp.sendPostRequest()
            }
        }
    }
    
    private func showAlert(message: String) {
        let alertController = UIAlertController(title: "错误提示", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "确定", style: UIAlertActionStyle.Default, handler: nil)
        alertController.addAction(okAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func networkUnavailable(identifier: String) {
        showAlert("您的网络当前不可用，请检查您的网络设置！")
    }
    
    func responseError(identifier: String) {
        showAlert("系统错误！")
    }
    
    func parseJsonResultError(identifier: String) {
        showAlert("请求结果解析异常！")
    }
    
    func endedSendRequestByJsonRespone(identifier: String, result: NSDictionary) {
//        let data = try! NSJSONSerialization.dataWithJSONObject(result, options: NSJSONWritingOptions.PrettyPrinted)
//        let strJson=NSString(data: data, encoding: NSUTF8StringEncoding)
//        print("json:\(strJson)")
        let rspCode: NSString = result.objectForKey("code") as! NSString
        if rspCode == "0000" {
            var orderType = ""
            if let masterinfo = result.objectForKey("masterinfo") as? NSDictionary {
                if let orderno = masterinfo["orderno"] as? String {
                    bodyView.orderInfoView.orderIdValue.text = orderno
                }
                if let state = masterinfo["state"] as? String {
                    bodyView.orderInfoView.orderStateValue.text = state
                }
                if let createtime = masterinfo["createtime"] as? String {
                    bodyView.orderInfoView.orderTimeValue.text = createtime
                }
                orderType = masterinfo["ordertype"] as? String ?? ""
            }
            if let carInfo = result.objectForKey("carinfo") as? NSDictionary {
                if let vehiclebrand = carInfo["vehiclebrand"] as? String {
                    bodyView.carInfoView.carBrandValue.text = vehiclebrand
                }
                if let vehiclesers = carInfo["vehiclesers"] as? String {
                    bodyView.carInfoView.carModelValue.text = vehiclesers
                }
                if let producetime = carInfo["producetime"] as? String {
                    bodyView.carInfoView.productDateValue.text = producetime
                }
                if let vehtralic = carInfo["vehtralic"] as? String {
                    let imgURL:NSURL=NSURL(string: vehtralic)!
                    let request:NSURLRequest=NSURLRequest(URL:imgURL)
                    NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(),
                        completionHandler: {(response, data, error)->Void in
                            if data != nil {
                                let img=UIImage(data:data!)
                                self.bodyView.carInfoView.uploadDrivingLicense.image = img
                            } else {
                                self.bodyView.carInfoView.uploadDrivingLicense.image = UIImage(named: "drivinglicense")
                            }
                    })
                } else {
                    bodyView.carInfoView.uploadDrivingLicense.image = UIImage(named: "drivinglicense")
                }
                if let tyre = carInfo["tyre"] as? String {
                    let imgURL:NSURL=NSURL(string: tyre)!
                    let request:NSURLRequest=NSURLRequest(URL:imgURL)
                    NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(),
                        completionHandler: {(response, data, error)->Void in
                            if data != nil {
                                let img=UIImage(data:data!)
                                self.bodyView.carInfoView.uploadTyre.image = img
                            } else {
                                self.bodyView.carInfoView.uploadTyre.image = UIImage(named: "defaulttyre")
                            }
                            
                    })
                } else {
                    bodyView.carInfoView.uploadTyre.image = UIImage(named: "defaulttyre")
                }
            }
            if let productInfo = result.objectForKey("goodinfo") as? NSDictionary {
                if let wheelseriesname = productInfo["wheelseriesname"] as? String {
                    bodyView.productInfoView.wheelTypeValue.text = wheelseriesname
                }
                if let technical = productInfo["technical"] as? String {
                    bodyView.productInfoView.productionTechnologyValue.text = OrderConfirmInfo.ResverProductionTechnologyInfo[technical]
                }
                if let wheeltype = productInfo["wheeltype"] as? String {
                    bodyView.productInfoView.wheelModelValue.text = "CGCG\(wheeltype)"
                }
                if let wheelcap = productInfo["wheelcap"] as? String {
                    bodyView.productInfoView.centerCoverValue.text = OrderConfirmInfo.ResverCenterCoverInfo[wheelcap]
                }
                if let wheelpic = productInfo["wheelpic"] as? String {
                    let imgURL:NSURL=NSURL(string: wheelpic)!
                    let request:NSURLRequest=NSURLRequest(URL:imgURL)
                    NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(),
                        completionHandler: {(response, data, error)->Void in
                            if data != nil {
                                let img=UIImage(data:data!)
                                self.bodyView.productInfoView.wheelColorValue.image.image = img
                            }
                    })
                }
                if orderType == "01" {
                    let lwColor = productInfo["spokecolor"]as? String ?? ""
                    let lyColor = productInfo["flangecolor"]as? String ?? ""
                    let lfColor = productInfo["rimcolor"]as? String ?? ""
                    bodyView.productInfoView.wheelColorValue.display.text = "轮辋(\(WheelColorInfo.Colors[lwColor]!))+轮缘(\(WheelColorInfo.Colors[lyColor]!))+轮辐(\(WheelColorInfo.Colors[lfColor]!))"
                } else if orderType == "03" {
                    bodyView.productInfoView.wheelColorValue.display.text = productInfo["rimcolor"]as? String ?? ""
                }
//                if let lfColor = productInfo["rimcolor"]as? String {
//                    bodyView.productInfoView.wheelColorForLf.color = lfColor
//                }
//                if let lwColor = productInfo["spokecolor"]as? String {
//                    bodyView.productInfoView.wheelColorForLw.color = lwColor
//                }
//                if let lyColor = productInfo["flangecolor"]as? String {
//                    bodyView.productInfoView.wheelColorForly.color = lyColor
//                }
                if let tyrepressure = productInfo["tyrepressure"] as? String {
                    bodyView.productInfoView.tirePressureHoleValue.text = OrderConfirmInfo.ResverTirePressureHoleInfo[tyrepressure]
                }
                if let brakedisc = productInfo["brakedisc"] as? String {
                    bodyView.productInfoView.brakeDiscValue.text = OrderConfirmInfo.ResverBrakeDiscInfo[brakedisc]
                }
                if let orderdetaillist = productInfo["orderdetaillist"] as? [Dictionary<String, AnyObject>] {
                    for wheelDetailInfo in orderdetaillist {
                        let wheellocation = wheelDetailInfo["wheellocation"] as? String ?? ""
                        if wheellocation == "F" {
                            if let sum = wheelDetailInfo["sum"] as? String {
                                bodyView.productInfoView.frontCountValue.text = sum
                            }
                            if let wheelsize = wheelDetailInfo["wheelsize"] {
                                bodyView.productInfoView.frontSizeValue.text = processFloatValue("\(wheelsize)", precision: 0)
                            }
                            if let wheelwidth = wheelDetailInfo["wheelwidth"] {
                                bodyView.productInfoView.frontWidthValue.text = processFloatValue("\(wheelwidth)", precision: 1)
                            }
                            if let wheelhole = wheelDetailInfo["wheelhole"] {
                                if let wheelpcd = wheelDetailInfo["wheelpcd"] {
                                    bodyView.productInfoView.frontPcdValue.text = "\(wheelhole) × " + processFloatValue("\(wheelpcd)", precision: 2)
                                }
                            }
                            if let wheelcbd = wheelDetailInfo["wheelcbd"] {
                                bodyView.productInfoView.frontCbdValue.text = processFloatValue("\(wheelcbd)", precision: 2)
                            }
                            if let wheelet = wheelDetailInfo["wheelet"] {
                                bodyView.productInfoView.frontEtValue.text = processFloatValue("\(wheelet)", precision: 0)
                            }
                        }
                        if wheellocation == "R" {
                            if let sum = wheelDetailInfo["sum"] as? String {
                                bodyView.productInfoView.rearCountValue.text = sum
                            }
                            if let wheelsize = wheelDetailInfo["wheelsize"] {
                                bodyView.productInfoView.rearSizeValue.text = processFloatValue("\(wheelsize)", precision: 0)
                            }
                            if let wheelwidth = wheelDetailInfo["wheelwidth"] {
                                bodyView.productInfoView.rearWidthValue.text = processFloatValue("\(wheelwidth)", precision: 1)
                            }
                            if let wheelhole = wheelDetailInfo["wheelhole"] {
                                if let wheelpcd = wheelDetailInfo["wheelpcd"] {
                                    bodyView.productInfoView.rearPcdValue.text = "\(wheelhole) × " + processFloatValue("\(wheelpcd)", precision: 2)
                                }
                            }
                            if let wheelcbd = wheelDetailInfo["wheelcbd"] {
                                bodyView.productInfoView.rearCbdValue.text = processFloatValue("\(wheelcbd)", precision: 2)
                            }
                            if let wheelet = wheelDetailInfo["wheelet"] {
                                bodyView.productInfoView.rearEtValue.text = processFloatValue("\(wheelet)", precision: 0)
                            }
                        }
                    }
                }
//                if let lfPicNamed = productInfo["rimpicid"] as? String {
//                    bodyView.productInfoView.wheelImage.lf.image = UIImage(named: lfPicNamed)
//                }
//                if let lwPicNamed = productInfo["spokepicid"] as? String {
//                    bodyView.productInfoView.wheelImage.lw.image = UIImage(named: lwPicNamed)
//                }
//                if let lyPicNamed = productInfo["flangepicid"] as? String {
//                    bodyView.productInfoView.wheelImage.ly.image = UIImage(named: lyPicNamed)
//                }
            }
            if let custmerinfo = result.objectForKey("custmerinfo") as? NSDictionary {
                if let carownername = custmerinfo["carownername"] as? String {
                    bodyView.custInfoView.custNameValue.text = carownername
                }
                if let carowertel = custmerinfo["carowertel"] as? String {
                    bodyView.custInfoView.phoneValue.text = carowertel
                }
                if let comment = custmerinfo["comment"] as? String {
                    bodyView.custInfoView.custMsgValue.text = comment
                }
            }
            if let deliverinfo = result.objectForKey("deliverinfo") as? NSDictionary {
                if deliverinfo.count == 0 {
                    bodyView.showLogistics = false
                } else {
                    bodyView.showLogistics = true
                }
                if let logisticsname = deliverinfo["logisticsname"] as? String {
                    bodyView.logisticsInfoView.logisticsCompanyValue.text = logisticsname
                }
                if let logisticsid = deliverinfo["logisticsid"] as? String {
                    bodyView.logisticsInfoView.wayBillIdValue.text = logisticsid
                }
                if let address = deliverinfo["address"] as? String {
                    bodyView.logisticsInfoView.addressValue.text = address
                }
            }
        } else if rspCode == "1004" {
            let signUp = LoginDialog.init(viewController: self, subView: bodyView)
            signUp.delgate = self
            signUp.showLoginDialog()
            return
        }
        calculateContent()
    }
    
    func calculateContent() {
        let orderInfoModuleHeight: CGFloat = bodyView.orderInfoModule.titleHeight + bodyView.orderInfoView.getHeight()
        let carInfoModuleHeight: CGFloat = bodyView.carInfoModule.titleHeight + bodyView.carInfoView.getHeight()
        let productInfoModuleHeight: CGFloat = bodyView.productInfoModule.titleHeight + bodyView.productInfoView.getHeight()
        let custInfoModuleHeight: CGFloat = bodyView.custInfoModule.titleHeight + bodyView.custInfoView.getHeight()
        var height = bodyView.topSpace + orderInfoModuleHeight + carInfoModuleHeight + productInfoModuleHeight + custInfoModuleHeight + bodyView.moduleSpace * 3 + bodyView.buttonSpace
        if bodyView.showLogistics {
            let logisticsInfoModuleHeight: CGFloat = bodyView.logisticsInfoModule.titleHeight + bodyView.logisticsInfoView.getHeight()
            height += bodyView.moduleSpace + logisticsInfoModuleHeight
        }
        bodyView.contentSize = CGSize(width: bodyView.bounds.width, height: height)
        bodyView.scrollEnabled = true
    }
    
    func loginDialogSuccessLogin() {
        loadOrderDetail()
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func closeDetail(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
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
