//
//  WheelBossDesignViewController.swift
//  WheelBossDesign
//
//  Created by 李秋声 on 16/2/7.
//  Copyright © 2016年 Leomond. All rights reserved.
//

import UIKit

class WheelBossDesignViewController: BaseWithBackViewController, ActionViewDataSource {

    @IBOutlet weak var designBody: DesignBodyView! {
        didSet {
            designBody.action.dataSource = self
        }
    }
    
    var seriesName: String = ""
    
    var wheelInfo: WheelBossInfo?
    
    var lwColor: String = "0"
    
    var lyColor: String = "0"
    
    var lfColor: String = "0"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        designBody.diagram.seriesName.text = seriesName
        designBody.diagram.modelName.text = wheelInfo?.displayName
        setDefaultInfo()
        designBody.action.resetButton.addTarget(self, action: Selector("reset:"), forControlEvents: .TouchUpInside)
        designBody.action.orderButton.addTarget(self, action: Selector("order:"), forControlEvents: .TouchUpInside)
        if seriesName == "锻造直通" {
            designBody.action.buttonsTitle = ["轮辋", "轮缘", "轮辐"]
        } else if seriesName == "冷璇直通" {
            designBody.action.buttonsTitle = ["轮辋", "轮缘+轮辐"]
        }
        // Do any additional setup after loading the view.
    }
    
    func setDefaultInfo() {
        designBody.diagram.previewView.lw.image = UIImage(named: getImageNamed(seriesName, modelName: (wheelInfo?.name)!, compomemt: "lw", colorName: "0"))!
        designBody.diagram.previewView.lf.image = UIImage(named: getImageNamed(seriesName, modelName: (wheelInfo?.name)!, compomemt: "lf", colorName: "0"))!
        if seriesName == "锻造直通" {
            designBody.diagram.previewView.ly.image = UIImage(named: getImageNamed(seriesName, modelName: (wheelInfo?.name)!, compomemt: "ly", colorName: "0"))!
        }
        
        lwColor = "0"
        lfColor = "0"
        lyColor = "0"
        let colorViews = designBody.action.colorSelectors
        for (_, value) in colorViews {
            value.selectedColorName = ""
        }
    }
    
    func getImageNamed(seriesName: String, modelName: String, compomemt: String, colorName: String) -> String {
        return getSeriesCode(seriesName) + "-" + modelName + "-M-" + compomemt + "-" + colorName
    }
    
    func getSeriesCode(seriesName: String) -> String {
        switch seriesName {
        case "锻造直通":
            return "dzzt"
        case "冷璇直通":
            return "lxzt"
        case "锻造2片":
            return "dz2p"
        default:
            return ""
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func back() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func reset(button: UIButton) {
        setDefaultInfo()
    }
    
    func order(button: UIButton) {
        self.performSegueWithIdentifier("showOrderConfirm", sender: self)
    }
    
    func showAlert(message: String) {
        let alertController = UIAlertController(title: "提示", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "确定", style: UIAlertActionStyle.Default, handler: nil)
        alertController.addAction(okAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func changeWheelColor(component: String, colorName: String) {
        switch component {
        case "轮辋":
            lwColor = colorName
            designBody.diagram.previewView.lw.image = UIImage(named: getImageNamed(seriesName, modelName: (wheelInfo?.name)!, compomemt: "lw", colorName: colorName))!
            break
        case "轮缘":
            lyColor = colorName
            designBody.diagram.previewView.ly.image = UIImage(named: getImageNamed(seriesName, modelName: (wheelInfo?.name)!, compomemt: "ly", colorName: colorName))!
            break
        case "轮辐":
            lfColor = colorName
            designBody.diagram.previewView.lf.image = UIImage(named: getImageNamed(seriesName, modelName: (wheelInfo?.name)!, compomemt: "lf", colorName: colorName))!
            break
        case "轮缘+轮辐":
            lyColor = colorName
            lfColor = colorName
            designBody.diagram.previewView.lf.image = UIImage(named: getImageNamed(seriesName, modelName: (wheelInfo?.name)!, compomemt: "lf", colorName: colorName))!
            break
        default:
            break
        }
    }
    
    lazy var context: CIContext = {
        return CIContext(options: nil)
    }()
    
    func compose() -> UIImage {
        let sourceOverCompositingFilter = CIFilter(name: "CISourceOverCompositing")!
        sourceOverCompositingFilter.setValue(CIImage(image: designBody.diagram.previewView.lw.image!),
            forKey: kCIInputBackgroundImageKey)
        sourceOverCompositingFilter.setValue(CIImage(image: designBody.diagram.previewView.lf.image!), forKey: kCIInputImageKey)
        var outputImage = sourceOverCompositingFilter.outputImage
        if seriesName == "锻造直通" {
            sourceOverCompositingFilter.setValue(CIImage(image: designBody.diagram.previewView.ly.image!), forKey: kCIInputImageKey)
            sourceOverCompositingFilter.setValue(outputImage, forKey: kCIInputBackgroundImageKey)
        }
        outputImage = sourceOverCompositingFilter.outputImage
        let cgImage = context.createCGImage(outputImage!, fromRect: outputImage!.extent)
        let sizeChange = CGSize(width: 150,height: 150)
        var img = UIImage(CGImage: cgImage)
        UIGraphicsBeginImageContextWithOptions(sizeChange, false, 0.0)
        img.drawInRect(CGRect(origin: CGPointZero, size: sizeChange))
        img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img
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
        if let result = dest as? OrderConfirmViewController {
            result.seriesName = seriesName
            result.wheelInfo = wheelInfo
            result.lfColor = lfColor
            result.lfImageName = getImageNamed(seriesName, modelName: (wheelInfo?.name)!, compomemt: "lf", colorName: lfColor)
            result.lwColor = lwColor
            result.lwImageName = getImageNamed(seriesName, modelName: (wheelInfo?.name)!, compomemt: "lw", colorName: lwColor)
            result.lyColor = lyColor
            result.lyImageName = getImageNamed(seriesName, modelName: (wheelInfo?.name)!, compomemt: "ly", colorName: lyColor)
            result.ordertype = "01"
            result.lunguPicture = compose()
        }
    }

}
