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
        view.addSubview(tabView)
        
        tabView.translatesAutoresizingMaskIntoConstraints = false
        tabView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tabView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tabView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        tabView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        configureTabContainerView()
    }
    
    func configureTabContainerView() {
        view.addSubview(tabContainerView)
        
        tabContainerView.translatesAutoresizingMaskIntoConstraints = false
        tabContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tabContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tabContainerView.topAnchor.constraint(equalTo: tabView.bottomAnchor).isActive = true
        tabContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
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
        switch selectedMenuItem.id {
        case "Location":
            showLocationHistoryModule()
            
        case "Screentime":
            showScreenTimeModule()
            
        case "Searches":
            showSearchesModule()
            
        case "Blocks":
            showBlocksModule()
            
        case "YouTube":
            showYoutubeHistoryModule()
        default:()
        }
    }
    
    
    
    func presentChildVC(_ vc: TabbedViewController) {
        self.children.forEach { (childVC) in
            if childVC is TabbedViewController {
                childVC.view.removeFromSuperview()
                childVC.removeFromParent()
            }
        }
        guard let vc = vc as? UIViewController else {
            return
        }
        self.addChild(vc)
        self.tabContainerView.addSubview(vc.view)
        
        vc.view.translatesAutoresizingMaskIntoConstraints = false
        vc.view.leadingAnchor.constraint(equalTo: tabContainerView.leadingAnchor).isActive = true
        vc.view.trailingAnchor.constraint(equalTo: tabContainerView.trailingAnchor).isActive = true
        vc.view.topAnchor.constraint(equalTo: tabContainerView.topAnchor).isActive = true
        vc.view.bottomAnchor.constraint(equalTo: tabContainerView.bottomAnchor).isActive = true
    }
    
    
    func showYoutubeHistoryModule() {
        if let vc = childModules["YouTube"],
            let cvcYoutube = vc as? TabbedViewController {
            presentChildVC(cvcYoutube)
        } else {
            let youtubeHistoryViewController = TempViewController()
            youtubeHistoryViewController.view.backgroundColor = .yellow
            
            presentChildVC(youtubeHistoryViewController)
            childModules["YouTube"] = youtubeHistoryViewController
        }
    }
    
    func showScreenTimeModule() {
        
        if let vc = childModules["Screentime"],
            let stApps = vc as? TabbedViewController {
            presentChildVC(stApps)
        } else {
            let screenTimeViewController = TempViewController()
            screenTimeViewController.view.backgroundColor = .green
            presentChildVC(screenTimeViewController)
            childModules["Screentime"] = screenTimeViewController
        }
    }
    
    func showSearchesModule() {
        if let vc = childModules["Searches"],
            let cvcSearches = vc as? TabbedViewController {
            presentChildVC(cvcSearches)
        } else {
            let searchesViewController = TempViewController()
            searchesViewController.view.backgroundColor = .orange
            presentChildVC(searchesViewController)
            childModules["Searches"] = searchesViewController
        }
    }
    
    func showBlocksModule() {
        if let vc = childModules["Blocks"],
            let cvcBlocks = vc as? TabbedViewController {
            presentChildVC(cvcBlocks)
        } else {
            let blocksViewController = TempViewController()
            presentChildVC(blocksViewController)
            childModules["Blocks"] = blocksViewController
        }
    }
    
    func showLocationHistoryModule() {
        
        if let vc = childModules["Location"],
            let cvcLocation = vc as? TabbedViewController {
            presentChildVC(cvcLocation)
        } else {
            let locationHistoryViewController = TempViewController()
            presentChildVC(locationHistoryViewController)
            childModules["Location"] = locationHistoryViewController
        }
    }
    
}

protocol TabbedViewController where Self: UIViewController {
    
}

class TempViewController: UIViewController, TabbedViewController {
    
}
