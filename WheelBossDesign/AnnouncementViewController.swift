//
//  AnnouncementViewController.swift
//  WheelBossDesign
//
//  Created by 李秋声 on 16/3/12.
//  Copyright © 2016年 Leomond. All rights reserved.
//

import UIKit

class AnnouncementViewController: UIViewController {
    
    let kBakcgroundTansperancy: CGFloat = 0.4
    var contentView = AnnouncementView()
    let contentViewHeight: CGFloat = 400
    let contentViewWidth: CGFloat = 300
    var strongSelf: AnnouncementViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.okButton.addTarget(self, action: "hideAnnouncement", forControlEvents: UIControlEvents.TouchUpInside)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.view.frame = UIScreen.mainScreen().bounds
        self.view.autoresizingMask = [UIViewAutoresizing.FlexibleHeight, UIViewAutoresizing.FlexibleWidth]
        self.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: kBakcgroundTansperancy)
        self.view.addSubview(contentView)
        
        //Retaining itself strongly so can exist without strong refrence
        strongSelf = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func hideAnnouncement() {
        self.view.removeFromSuperview()
        self.strongSelf = nil
    }
    
    private func setupContentView() {
        contentView.backgroundColor = UIColor(white: 1.0, alpha: 0.9)
        contentView.layer.cornerRadius = 5.0
        contentView.layer.masksToBounds = true
        contentView.layer.borderWidth = 0.5
        contentView.layer.borderColor = UIColor(red: 153 / 255, green: 153 / 255, blue: 153 / 255, alpha: 1).CGColor
        
        contentView.frame = CGRectMake((UIScreen.mainScreen().bounds.size.width - contentViewWidth) / 2, (UIScreen.mainScreen().bounds.size.height - contentViewHeight) / 2, contentViewWidth, contentViewHeight)
        view.addSubview(contentView)
    }

    
    func showAlert() {
        let window: UIWindow = UIApplication.sharedApplication().keyWindow!
        window.addSubview(view)
        window.bringSubviewToFront(view)
        view.frame = window.bounds
        setupContentView()
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
