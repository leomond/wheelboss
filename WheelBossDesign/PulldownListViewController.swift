//
//  PulldownListViewController.swift
//  WheelBossDesign
//
//  Created by 李秋声 on 16/2/28.
//  Copyright © 2016年 Leomond. All rights reserved.
//

import UIKit

protocol PulldownListViewControllerDataSource: class {
    func selectTableInfo(info: String)
}

class PulldownListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
            tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        }
    }
    
    var tableData: [String]?
    
    var tableWidth: CGFloat?
    
    weak var dataSource: PulldownListViewControllerDataSource?
    
    var tableCellHeight: CGFloat = 44
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return tableCellHeight
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        let row = indexPath.row as Int
        cell.textLabel!.text = tableData?[row] ?? ""
        cell.accessoryType  = UITableViewCellAccessoryType.None
        cell.selectionStyle = UITableViewCellSelectionStyle.Gray
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let row = indexPath.row as Int
        dataSource?.selectTableInfo((tableData?[row])!)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override var preferredContentSize: CGSize {
        get {
            if tableData != nil && tableData?.count > 0 && presentingViewController != nil {
                return CGSize(width: tableWidth!, height: tableCellHeight * CGFloat((tableData?.count)!))
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
