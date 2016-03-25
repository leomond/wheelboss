//
//  WheelBossDesignHomeUIViewController.swift
//  WheelBossDesign
//
//  Created by 李秋声 on 16/1/31.
//  Copyright © 2016年 Leomond. All rights reserved.
//

import UIKit

class WheelBossDesignHomeViewController: BaseWithBackViewController, WBDBodyViewDataSource, WBDHomeTabViewDataSource, LeomondHttpDelegate {
    
    @IBOutlet weak var homeView: WBDHomeView! {
        didSet {
            homeView.bodyView.addGestureRecognizer(UIPanGestureRecognizer(target: homeView.bodyView, action: "panned:"))
            homeView.bodyView.dataSource = self
            homeView.titleView.dataSource = self
        }
    }

    override func back() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    var wheelInfo: WheelBossInfo?
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeView.titleView.titles = ["锻造直通", "冷璇直通", "锻造2片"]
//        homeView.titleView.titles = ["锻造直通", "冷璇直通"]
        reloadWBDBody(homeView.titleView.focusButton)
        
        loadInfoFromServer()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadInfoFromServer() {
        let info = defaults.objectForKey(SignInConstants.LoginStateMark)
        if let tokenInfo = info as? Dictionary<String, String> {
            if let token = tokenInfo["accesstoken"] {
                let parameters = [
                    "accesstoken": token
                ]
                
                let httpReq = LeomondHttp.init(identifier: "querySeriesList", uri: URIConstants.QuerySeriesList, parameters: parameters, loadingTips: true, viewController: self, subView: self.view)
                httpReq.delegate = self
                httpReq.sendPostRequest()
            }
        }
    }
    
    func responseError(identifier: String) {
        
    }
    
    func networkUnavailable(identifier: String) {
        
    }
    
    func endedSendRequestByJsonRespone(identifier: String, result: NSDictionary) {
        
    }
    
    func designWheelBoss(wheelInfo: WheelBossInfo) {
        self.wheelInfo = wheelInfo
//        if homeView.titleView.focusButton == "锻造直通" && wheelInfo.name != "008" && wheelInfo.name != "011" {
//            self.performSegueWithIdentifier("showWheelBossDesign", sender: self)
//        }
        self.performSegueWithIdentifier("showWheelBossDesign", sender: self)
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        var des = segue.destinationViewController as UIViewController
        if let destination = des as? UINavigationController {
            des = destination.visibleViewController!
        }
        if let result = des as? WheelBossDesignViewController {
            result.seriesName = homeView.titleView.focusButton
            result.wheelInfo = wheelInfo
        }
    }
    
    func reloadWBDBody(focusButton: String) {
        if focusButton == "锻造2片" {
            homeView.comingsoon = true
        } else {
            homeView.comingsoon = false
            homeView.bodyView.wheelList = getWheelList(homeView.titleView.focusButton)
        }
    }
    
    func getWheelList(seriesName: String) -> [WheelBossInfo] {
        switch seriesName {
        case "锻造直通":
            return [WheelBossInfo(name: "001", picture: "001"), WheelBossInfo(name: "002", picture: "002"), WheelBossInfo(name: "003", picture: "003"), WheelBossInfo(name: "004", picture: "004"), WheelBossInfo(name: "005", picture: "005"), WheelBossInfo(name: "006", picture: "006"), WheelBossInfo(name: "007", picture: "007"), WheelBossInfo(name: "008", picture: "008"), WheelBossInfo(name: "009", picture: "009"), WheelBossInfo(name: "010", picture: "010"), WheelBossInfo(name: "011", picture: "011"), WheelBossInfo(name: "012", picture: "012")]
        case "冷璇直通":
            return [WheelBossInfo(name: "225", picture: "225"), WheelBossInfo(name: "226", picture: "226"), WheelBossInfo(name: "227", picture: "227"), WheelBossInfo(name: "228", picture: "228"), WheelBossInfo(name: "300", picture: "300")]
        default:
            return [WheelBossInfo(name: "301", picture: "010"), WheelBossInfo(name: "302", picture: "011"), WheelBossInfo(name: "303", picture: "012"), WheelBossInfo(name: "304", picture: "009"), WheelBossInfo(name: "305", picture: "008")]
        }
    }

}
