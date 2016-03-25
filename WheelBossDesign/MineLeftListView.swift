//
//  MineLeftListView.swift
//  WheelBossDesign
//
//  Created by 李秋声 on 16/2/8.
//  Copyright © 2016年 Leomond. All rights reserved.
//

import UIKit

protocol MineLeftListViewDataSource: class {
    func doClickListViewCell(identifier: String)
}

class MineLeftListView: UIView, MineLeftListCellDataSource {
    
    var menuViews: Dictionary<String, MineLeftListCellView> = Dictionary<String, MineLeftListCellView>()
    
    var menuHeight: CGFloat = 44 {didSet {setNeedsDisplay()}}
    
    var selectedMenu: String = "myOrder" {didSet {setNeedsDisplay()}}
    var lastSelectedMenu: String = "myOrder"
    
    weak var dataSource: MineLeftListViewDataSource?

    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        
        let menuTitles = MineLeftMenu.DefaultMimeLeftMenuOrder
        for var index: Int = 0; index < menuTitles.count; index++ {
            let cell: MineLeftListCellView = menuViews[menuTitles[index]] ?? MineLeftListCellView()
            if cell.bounds.origin.x == 0 {
                cell.dataSource = self
                cell.addGestureRecognizer(UITapGestureRecognizer(target: cell, action: "clickMenu:"))
            }
            cell.frame = CGRectMake(0, menuHeight * CGFloat(index), bounds.size.width, menuHeight)
            let cellInfo = MineLeftMenu.DefaultMimeLeftMenu[menuTitles[index]]
            cell.title = (cellInfo?.title)!
            cell.identifier = menuTitles[index]
            cell.backgroundColor = UIColor.clearColor()
            if menuTitles[index] == selectedMenu {
                cell.imageNamed = (cellInfo?.icon)!
                cell.selected = true
            } else {
                cell.imageNamed = (cellInfo?.unselectedIcon)!
                cell.selected = false
            }
            menuViews[menuTitles[index]] = cell
            addSubview(cell)
        }
    }
    
    func onClickListCell(identifier: String) {
        lastSelectedMenu = selectedMenu
        selectedMenu = identifier
        dataSource?.doClickListViewCell(identifier)
    }

}
