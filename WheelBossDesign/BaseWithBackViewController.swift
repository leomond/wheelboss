//
//  BaseWithBackViewController.swift
//  WheelBossDesign
//
//  Created by 李秋声 on 16/2/19.
//  Copyright © 2016年 Leomond. All rights reserved.
//

import UIKit

class BaseWithBackViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let backButton = UIButton(frame: CGRectMake(0, 20, 86, 36))
        backButton.setBackgroundImage(UIImage(named: "back"), forState: .Normal)
        backButton.addTarget(self, action: "back", forControlEvents: UIControlEvents.TouchUpInside)
        let backItem = UIBarButtonItem(customView: backButton)
        self.navigationItem.rightBarButtonItem = backItem

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func back() {
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
