//
//  PicturesHomeViewController.swift
//  WheelBossDesign
//
//  Created by 李秋声 on 16/1/31.
//  Copyright © 2016年 Leomond. All rights reserved.
//

import UIKit

class PicturesHomeViewController: BaseWithBackViewController, PicturesHeaderViewDataSource, PicturesBodyScrollViewDataSource, LeomondHttpDelegate {

    @IBOutlet weak var header: PicturesHeaderView! {
        didSet {
            header.dataSource = self
        }
    }
    @IBOutlet weak var body: PicturesBodyScrollView! {
        didSet {
            body.dataSource = self
        }
    }
    
    var pictureInfo: PicturesInfo?
    
    override func back() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        header.titles = ["全拉丝", "全涂装"]
        
        loadPictures()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadPictures() {
        let defaults = NSUserDefaults.standardUserDefaults()
        let info = defaults.objectForKey(SignInConstants.LoginStateMark)
        if let tokenInfo = info as? Dictionary<String, String> {
            if let loginInfo = tokenInfo["accesstoken"] {
                let token = loginInfo as String
                let parameters = [
                    "accesstoken": token,
                    "page": "1",
                    "rowcount": "100",
                    "pictype": "03",
                    "technical": getTechnicalbyName()
                ]
                let reqHttp = LeomondHttp.init(identifier: "loadPictures", uri: URIConstants.PicShow, parameters: parameters, loadingTips: true, viewController: self, subView: view)
                reqHttp.delegate = self
                reqHttp.sendPostRequest()
            }
        }
    }
    
    func getTechnicalbyName() -> String {
        var result = ""
        switch header.focusButton {
        case "全拉丝":
            result = "L"
            break
        case "全涂装":
            result = "S"
            break
        default:
            break
        }
        return result
    }
    
    func networkUnavailable(identifier: String) {
        
    }
    
    func responseError(identifier: String) {
        
    }
    
    func endedSendRequestByJsonRespone(identifier: String, result: NSDictionary) {
        switch identifier {
        case "loadPictures":
            processLoadPictures(result)
            break
        default:
            break
        }
    }
    
    func processLoadPictures(result: NSDictionary) {
        let rspCode: NSString = result.objectForKey("code") as! NSString
        if rspCode == "0000" {
            let picshowlist = result.objectForKey("picshowlist") as! [NSDictionary]
            var pictures = [PicturesInfo]()
            for picture in picshowlist {
                var pic = PicturesInfo()
                pic.id = picture.objectForKey("picid") as? String ?? ""
                pic.chromaticalid = picture.objectForKey("chromaticalid") as? String ?? ""
                pic.chromaticalname = picture.objectForKey("chromaticalname") as? String ?? ""
                pic.fullscreenUrl = picture.objectForKey("fullscreenpicurl") as? String ?? ""
                pic.listUrl = picture.objectForKey("picurl") as? String ?? ""
                pic.technical = picture.objectForKey("technical") as? String ?? ""
                pic.wheelseriesname = picture.objectForKey("wheelseriesname") as? String ?? ""
                pic.wheeltype = picture.objectForKey("wheeltype") as? String ?? ""
                pictures += [pic]
            }
            body.pictures = pictures
            let viewWidth: CGFloat = (body.bounds.size.width - body.space * CGFloat(body.columnCount + 1)) / CGFloat(body.columnCount)
            let viewHeight: CGFloat = viewWidth * body.heightWidthRatio
            var rowCount: Int = pictures.count / body.columnCount + 1
            if pictures.count % body.columnCount > 0 {
                rowCount += 1
            }
            let contentHeight: CGFloat = viewHeight * CGFloat(rowCount) + body.space * CGFloat(rowCount + 1)
            body.contentSize = CGSize(width: body.bounds.width, height: max(contentHeight, body.bounds.height))
            body.scrollEnabled = true
        }
    }
    
    func reloadPcturesHomeBody(focusButton: String) {
        loadPictures()
    }
    
    func doViewLarge(pictureInfo: PicturesInfo) {
        self.pictureInfo = pictureInfo
        self.performSegueWithIdentifier("showViewLarger", sender: self)
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
        if let result = dest as? PicturesLargerViewController {
            result.pictureInfo = pictureInfo
        }
    }

}
