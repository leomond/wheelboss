//
//  BuyersShowListViewController.swift
//  WheelBossDesign
//
//  Created by 李秋声 on 16/1/31.
//  Copyright © 2016年 Leomond. All rights reserved.
//

import UIKit

class BuyersShowListViewController: BaseWithBackViewController {

    override func back() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
