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
        tabMenuView.configure(backgroundColor: .white)
        tabMenuView.selectTabMenuItem(index: 0)
    }
    
    var tabMenuView = ZiftTabMenuView()
    
    func configureTabMenuConstraints() {
        view.addSubview(tabMenuView)
        
        tabMenuView.translatesAutoresizingMaskIntoConstraints = false
        tabMenuView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tabMenuView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tabMenuView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        tabMenuView.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
    func configureTabMenuItems() {
        tabMenuView.addTabMenuItem(title: "Searches", icon: UIImage(named: "SearchesTabIcon"), id: "Searches", selectedTabTitleColor: .ziftSelectedTabTitle) { [weak self] in
            self?.tabMenuSelectedHandler()
        }

        tabMenuView.addTabMenuItem(title: "Screentime", icon: UIImage(named: "SearchesTabIcon"), id: "Screentime") { [weak self] in
            self?.tabMenuSelectedHandler()
        }

        tabMenuView.addTabMenuItem(title: "Blocks & Alerts", icon: UIImage(named: "SearchesTabIcon"), id: "Blocks") { [weak self] in
            self?.tabMenuSelectedHandler()
        }

        tabMenuView.addTabMenuItem(title: "YouTube", icon: UIImage(named: "SearchesTabIcon"), id: "YouTube") { [weak self] in
            self?.tabMenuSelectedHandler()
        }

        tabMenuView.addTabMenuItem(title: "Location", icon: UIImage(named: "SearchesTabIcon"), id: "Location") { [weak self] in
            self?.tabMenuSelectedHandler()
        }
    }
    
    func tabMenuSelectedHandler() {
        guard let selectedMenuItem = tabMenuView.tabMenuItemsArray.filter({$0.isSelected}).first else {
            return
        }
        
        print(selectedMenuItem.id)
    }
}

