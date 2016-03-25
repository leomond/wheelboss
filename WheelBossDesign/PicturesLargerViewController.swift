//
//  PicturesLargerViewController.swift
//  WheelBossDesign
//
//  Created by 李秋声 on 16/3/22.
//  Copyright © 2016年 Leomond. All rights reserved.
//

import UIKit

class PicturesLargerViewController: BaseWithBackViewController {
    
    var pictureInfo: PicturesInfo?

    @IBOutlet weak var picture: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imgURL:NSURL=NSURL(string: (pictureInfo?.fullscreenUrl)!)!
        let request:NSURLRequest=NSURLRequest(URL:imgURL)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(),
            completionHandler: {(response, data, error)->Void in
                if data != nil {
                    let img=UIImage(data:data!)
                    self.picture.image = img
                }
        })

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func back() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func order(sender: UIButton) {
        self.performSegueWithIdentifier("picturesToOrderConfirm", sender: self)
    }
    
    lazy var context: CIContext = {
        return CIContext(options: nil)
    }()
    
    func cutImage() -> UIImage {
//        var rgb: [Float] = [216, 227, 221]
//        var hsv: Float = 0
//        rgbToHSV(&rgb, &hsv)
//        print("hsv: \(hsv)")
//        let cubeMap = createCubeMap(200,220)
//        let data = NSData(bytesNoCopy: cubeMap.data, length: Int(cubeMap.length),
//            freeWhenDone: true)
//        
//        //消除某种颜色
//        let colorCubeFilter = CIFilter(name: "CIColorCube")!
//        colorCubeFilter.setValue(cubeMap.dimension, forKey: "inputCubeDimension")
//        colorCubeFilter.setValue(data, forKey: "inputCubeData")
//        colorCubeFilter.setValue(CIImage(image: picture.image!), forKey: kCIInputImageKey)
//        let outputImage = colorCubeFilter.outputImage
//        
//        let cgImage = context.createCGImage(outputImage!, fromRect: outputImage!.extent)
//        let pureImg = UIImage(CGImage: cgImage)
//        return pureImg
        
        let cgRef = picture.image?.CGImage
        let x: CGFloat = 50
        let y: CGFloat = 0
        let side: CGFloat = picture.bounds.size.height - 2 * y
        let imageRef = CGImageCreateWithImageInRect(cgRef, CGRectMake(x, y, side, side))
        return UIImage(CGImage: imageRef!)
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
            result.picutresInfo = pictureInfo
            result.ordertype = "03"
            result.lunguPicture = cutImage()
        }
    }

}
