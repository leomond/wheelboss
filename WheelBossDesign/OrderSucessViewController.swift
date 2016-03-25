//
//  OrderSucessViewController.swift
//  WheelBossDesign
//
//  Created by 李秋声 on 16/2/23.
//  Copyright © 2016年 Leomond. All rights reserved.
//

import UIKit

class OrderSucessViewController: BaseWithBackViewController {

    @IBOutlet weak var orderIdLabel: UILabel!
    
    var orderId: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        orderIdLabel.text = orderId
        orderIdLabel.contentMode = .TopLeft
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func back() {
        backMainHome()
    }
    
    @IBAction func queryOrder(sender: UIButton) {
        self.performSegueWithIdentifier("showMyBusiness", sender: self)
    }

    @IBAction func backHome(sender: UIButton) {
        backMainHome()
    }
    
    func backMainHome() {
        let story = UIStoryboard(name: "Main", bundle: nil)
        let vc = story.instantiateViewControllerWithIdentifier("home") as! UINavigationController
        self.presentViewController(vc, animated: true, completion: nil)
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
