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
    
    lazy var tabView = TabView(settings: TabViewSettings())
    
    lazy var tabContainerView: UIView = {
        let tabView = UIView()
        tabView.backgroundColor = .blue
        return tabView
    }()
    
    var childModules: [String: UIViewController] = [:]
    
    func configureTabMenuConstraints() {
        view.addSubview(tabView.view)
        self.addChild(tabView)
        tabView.view.translatesAutoresizingMaskIntoConstraints = false
        tabView.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tabView.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tabView.view.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        tabView.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func configureTabContainerView() {
        view.addSubview(tabContainerView)
        
        tabContainerView.translatesAutoresizingMaskIntoConstraints = false
        tabContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tabContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tabContainerView.topAnchor.constraint(equalTo: tabView.view.bottomAnchor).isActive = true
        tabContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func configureTabMenuItems() {
        
        let vc1 = TempViewController()
        vc1.view.backgroundColor = .orange
        tabView.addTabItem(tabItem: TabItemView(settings: tabView.settings.tabMenuItemSettings, vc: vc1, id: "Searches", title: "Searches", iconImage: UIImage(named: "SearchesTabIcon")!), tapHandler:  { [weak self] in
            self?.tabSelectedHandler()
        })
        
        
        let vc2 = TempViewController()
        vc2.view.backgroundColor = .yellow
        tabView.addTabItem(tabItem: TabItemView(settings: tabView.settings.tabMenuItemSettings, vc: vc2, id: "Screentime", title: "Screentime", iconImage: UIImage(named: "SearchesTabIcon")!), tapHandler:  { [weak self] in
                self?.tabSelectedHandler()
        })

        
        let vc3 = TempViewController()
        vc3.view.backgroundColor = .blue
        tabView.addTabItem(tabItem: TabItemView(settings: tabView.settings.tabMenuItemSettings, vc: vc3, id: "Blocks", title: "Blocks & Alerts", iconImage: UIImage(named: "SearchesTabIcon")!), tapHandler:  { [weak self] in
            self?.tabSelectedHandler()
        })
        
        let vc4 = TempViewController()
        vc4.view.backgroundColor = .black
        tabView.addTabItem(tabItem: TabItemView(settings: tabView.settings.tabMenuItemSettings, vc: vc4, id: "YouTube", title: "YouTube", iconImage: UIImage(named: "SearchesTabIcon")!), tapHandler:  { [weak self] in
            self?.tabSelectedHandler()
        })

        let vc5 = TempViewController()
        vc5.view.backgroundColor = .cyan
        tabView.addTabItem(tabItem: TabItemView(settings: tabView.settings.tabMenuItemSettings,  vc: vc5, id: "Location", title: "Location", iconImage: UIImage(named: "SearchesTabIcon")!), tapHandler:  { [weak self] in
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


class TempViewController: UIViewController, TabbedViewController {
    
}
