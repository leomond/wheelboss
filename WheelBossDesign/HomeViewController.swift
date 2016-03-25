//
//  HomeViewController.swift
//  WheelBossDesign
//
//  Created by 李秋声 on 16/1/28.
//  Copyright © 2016年 Leomond. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController, HomeLeftDataSource, HomeRightViewDataSource {
    
    private struct Constants {
        static let LeftWheelBackgroud: String = "home-hub"
    }
    @IBOutlet weak var homeBody: HomeBodyView! {
        didSet {
            homeBody.leftView.dataSource = self
            homeBody.leftView.addGestureRecognizer(UIPanGestureRecognizer(target: homeBody.leftView, action: "slip:"))
            
            homeBody.rightView.dataSource = self
            homeBody.rightView.addGestureRecognizer(UITapGestureRecognizer(target: homeBody.rightView, action: "click:"))
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homeButton = UIButton(frame: CGRectMake(0, 20, 86, 36))
        homeButton.setBackgroundImage(UIImage(named: "home-icon"), forState: .Normal)
        homeButton.addTarget(self, action: "send", forControlEvents: UIControlEvents.TouchUpInside)
        let homeItem = UIBarButtonItem(customView: homeButton)
        self.navigationItem.rightBarButtonItem = homeItem
        
        let leftViewDestination = homeBody.leftView.frame.origin.x
        homeBody.leftView.frame.origin.x = leftViewDestination - homeBody.leftView.bounds.size.width
        let rightViewDestination = homeBody.rightView.frame.origin.x
        homeBody.rightView.frame.origin.x = rightViewDestination + homeBody.rightView.bounds.size.width
        UIView.animateWithDuration(0.4) { () -> Void in
            self.homeBody.leftView.frame.origin.x = leftViewDestination
            self.homeBody.rightView.frame.origin.x = rightViewDestination
        }
        
        homeBody.leftView.centerImage.image = UIImage(named: Constants.LeftWheelBackgroud)!

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func send() {
//        UIView.beginAnimations(nil, context: nil)
//        UIView.setAnimationDuration(0.4)
//        
//        UIView.setAnimationTransition(.FlipFromLeft, forView: leftView, cache: true)
//        leftView.exchangeSubviewAtIndex(1, withSubviewAtIndex: 0)
//        UIView.commitAnimations()
//        
//        UIView.beginAnimations("animation", context: nil)
//        UIView.setAnimationDuration(2)
//        UIView.setAnimationCurve(UIViewAnimationCurve.Linear)
//        UIView.setAnimationTransition(.FlipFromLeft, forView: self.view, cache: false)
//        UIView.commitAnimations()
        self.performSegueWithIdentifier("homeToMyBusiness", sender: self)
    }
    
    func changeRightViewBkg(homeRight: HomeRightStaff) {
        self.homeBody.rightView.bkgImageView.image = UIImage(named: homeRight.background)!
        self.homeBody.rightView.identifier = homeRight.identifier
        self.homeBody.rightView.bkgImageView.setNeedsDisplay()
    }
    
    func clickAction(identifier: String) {
        hop(identifier)
    }
    
    func clickFocusedAction(identifier: String) {
        hop(identifier)
    }
    
    private func hop(identifier: String) {
        self.performSegueWithIdentifier(identifier, sender: self)
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

extension UIImage {
    
    static func imageWithColor(color: UIColor) -> UIImage {
        
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        CGContextSetFillColorWithColor(context, color.CGColor)
        CGContextFillRect(context, rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
    
}
