//
//  ViewController.swift
//  ZiftTabMenu
//
//  Created by Andrey on 13/08/2020.
//  Copyright © 2020 Andrey. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabMenuConstraints()
        configureTabMenuItems()
        tabMenuView.selectTabMenuItem(index: 0)
    }
    
    var tabMenuView = ZiftTabMenuView(settings: ZiftTabMenuSettings())
    
    func configureTabMenuConstraints() {
        view.addSubview(tabMenuView)
        
        tabMenuView.translatesAutoresizingMaskIntoConstraints = false
        tabMenuView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tabMenuView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tabMenuView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        tabMenuView.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
    func configureTabMenuItems() {
 
        tabMenuView.addTabMenuItem(tabMenuItem: ZiftTabMenuItemView(settings: ZiftTabMenuItemSettings(id: "Searches", title: "Searches", titleOffset: UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 0), iconImage: UIImage(named: "SearchesTabIcon")!)), tapHandler:  { [weak self] in
            self?.tabMenuSelectedHandler()
        })

        
        tabMenuView.addTabMenuItem(tabMenuItem: ZiftTabMenuItemView(settings: ZiftTabMenuItemSettings(id: "Screentime", title: "Screentime", iconImage: UIImage(named: "SearchesTabIcon")!)), tapHandler:  { [weak self] in
            self?.tabMenuSelectedHandler()
        })

        tabMenuView.addTabMenuItem(tabMenuItem: ZiftTabMenuItemView(settings: ZiftTabMenuItemSettings(id: "Blocks", title: "Blocks & Alerts", iconImage: UIImage(named: "SearchesTabIcon")!)), tapHandler:  { [weak self] in
            self?.tabMenuSelectedHandler()
        })

        tabMenuView.addTabMenuItem(tabMenuItem: ZiftTabMenuItemView(settings: ZiftTabMenuItemSettings(id: "YouTube", title: "YouTube", iconImage: UIImage(named: "SearchesTabIcon")!)), tapHandler:  { [weak self] in
            self?.tabMenuSelectedHandler()
        })

        tabMenuView.addTabMenuItem(tabMenuItem: ZiftTabMenuItemView(settings: ZiftTabMenuItemSettings(id: "Location", title: "Location", iconImage: UIImage(named: "SearchesTabIcon")!)), tapHandler:  { [weak self] in
            self?.tabMenuSelectedHandler()
        })
        
    }
    
    func tabMenuSelectedHandler() {
        guard let selectedMenuItem = tabMenuView.tabMenuItemsArray.filter({$0.isSelected}).first else {
            return
        }
        print(selectedMenuItem.settings.id)
    }
}

