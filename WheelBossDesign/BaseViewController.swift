//
//  BaseViewController.swift
//  WheelBossDesign
//
//  Created by 李秋声 on 16/2/19.
//  Copyright © 2016年 Leomond. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // modify navigation translucent
        let semiBlackColor = UIColor(red:1,green:1,blue:1,alpha:0.5)
        navigationController?.navigationBar.setBackgroundImage(UIImage.imageWithColor(semiBlackColor), forBarMetrics: .Default)
        navigationController?.navigationBar.translucent = true
        
        let logoButton = UIButton(frame: CGRectMake(0, 20, 104, 30))
        logoButton.setBackgroundImage(UIImage(named: "logo"), forState: .Normal)
        logoButton.userInteractionEnabled = false
        let logoItem = UIBarButtonItem(customView: logoButton)
        self.navigationItem.leftBarButtonItem = logoItem
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
