//
//  PulldownGroupListViewController.swift
//  WheelBossDesign
//
//  Created by 李秋声 on 16/2/28.
//  Copyright © 2016年 Leomond. All rights reserved.
//

import UIKit

protocol PulldownGroupListViewControllerDataSource: class {
    func selectedGroupPulldownInfo(info: String)
}

class PulldownGroupListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
            tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        }
    }
    
    var tableData: Dictionary<String, [String]>?
    
    var sectionData: [String]?
    
    var tableWidth: CGFloat?
    
    weak var dataSource: PulldownGroupListViewControllerDataSource?
    
    var tableCellHeight: CGFloat = 44
    
    var tableSectionHeight: CGFloat = 20
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sectionData?.count ?? 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return tableCellHeight
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData?[(sectionData?[section])!]?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        let section = indexPath.section as Int
        let ret = tableData?[(sectionData?[section])!] ?? [String]()
        let row = indexPath.row as Int
        cell.textLabel!.text = ret[row] ?? ""
        cell.accessoryType  = UITableViewCellAccessoryType.None
        cell.selectionStyle = UITableViewCellSelectionStyle.Gray
        return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionData?[section] ?? ""
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return tableSectionHeight
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let section = indexPath.section as Int
        let ret = tableData?[(sectionData?[section])!] ?? [String]()
        let row = indexPath.row as Int
        dataSource?.selectedGroupPulldownInfo(ret[row])
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override var preferredContentSize: CGSize {
        get {
            if sectionData != nil && sectionData?.count > 0 && presentingViewController != nil {
                var height: CGFloat = CGFloat((sectionData?.count)!) * tableSectionHeight
                for (_, value) in tableData! {
                    height += CGFloat(value.count) * tableCellHeight
                }
                return CGSize(width: tableWidth!, height: height)
            } else {
                return super.preferredContentSize
            }
        }
        set { super.preferredContentSize = newValue }
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
