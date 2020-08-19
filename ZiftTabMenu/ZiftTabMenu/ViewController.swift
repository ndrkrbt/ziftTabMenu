//
//  ViewController.swift
//  
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
        tabView.selectTabItem(index: 0)
    }
    
    var tabView = TabView(settings: TabViewSettings())
    
    func configureTabMenuConstraints() {
        view.addSubview(tabView)
        
        tabView.translatesAutoresizingMaskIntoConstraints = false
        tabView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tabView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tabView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        tabView.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
    func configureTabMenuItems() {
        
        tabView.addTabItem(tabItem: TabItemView(settings: tabView.settings.tabMenuItemSettings, id: "Searches", title: "Searches", iconImage: UIImage(named: "SearchesTabIcon")!), tapHandler:  { [weak self] in
            self?.tabSelectedHandler()
        })
        
        tabView.addTabItem(tabItem: TabItemView(settings: tabView.settings.tabMenuItemSettings, id: "Screentime", title: "Screentime", iconImage: UIImage(named: "SearchesTabIcon")!), tapHandler:  { [weak self] in
            self?.tabSelectedHandler()
        })
        
        tabView.addTabItem(tabItem: TabItemView(settings: tabView.settings.tabMenuItemSettings,id: "Blocks", title: "Blocks & Alerts", iconImage: UIImage(named: "SearchesTabIcon")!), tapHandler:  { [weak self] in
            self?.tabSelectedHandler()
        })
        
        tabView.addTabItem(tabItem: TabItemView(settings: tabView.settings.tabMenuItemSettings,id: "YouTube", title: "YouTube", iconImage: UIImage(named: "SearchesTabIcon")!), tapHandler:  { [weak self] in
            self?.tabSelectedHandler()
        })
        
        tabView.addTabItem(tabItem: TabItemView(settings: tabView.settings.tabMenuItemSettings,id: "Location", title: "Location", iconImage: UIImage(named: "SearchesTabIcon")!), tapHandler:  { [weak self] in
            self?.tabSelectedHandler()
        })
    }
    
    func tabSelectedHandler() {
        guard let selectedMenuItem = tabView.tabItemsArray.filter({$0.isSelected}).first else {
            return
        }
        print(selectedMenuItem.id)
    }
}

