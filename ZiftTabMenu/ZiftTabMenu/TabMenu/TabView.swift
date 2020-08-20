//
//  TabView.swift
//
//
//  Created by Filipp Lebedev on 09.04.2018.
//  Copyright © 2018 ESCape-tech. All rights reserved.
//

import UIKit

protocol TabbedViewController where Self: UIViewController {
    
}


class TabView: UIViewController {
    
    var settings: TabViewSettings
    var tabItemsArray: [TabItemView] = []
    private var variableConstraintGroup: [NSLayoutConstraint] = []
    private var constantConstraintGroup: [NSLayoutConstraint] = []
    
    lazy var notSelectedContainerView = UIView()
    lazy var scrollContainerView = UIView()
    lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.showsVerticalScrollIndicator = false
        scroll.showsHorizontalScrollIndicator = false
        return scroll
    }()
    lazy var childrenContainer = UIView()
    var childrenControllers: [TabbedViewController] = []
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        notSelectedContainerView.layer.cornerRadius = 12
        notSelectedContainerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    convenience init() {
        self.init(settings: TabViewSettings())
    }
    
    init(settings: TabViewSettings) {
        self.settings = settings
        super.init(nibName: nil, bundle: nil)
        configureViews()
        configureNotselectedContainerView()
        notSelectedContainerView.backgroundColor = settings.backgroundColor
        view.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
       
    func addTabItem(tabItem: TabItemView, tapHandler: @escaping ()->Void) {
        scrollContainerView.addSubview(tabItem)
        tabItem.tabItemTapHandler = { [weak self] index in
            guard let self = self else {
                return
            }
            self.recalcTabConstraints(selectedIndex: index)
            for item in 0..<self.tabItemsArray.count {
                self.tabItemsArray[item].isSelected = item == index
            }
            self.presentChildVC(vc: self.childrenControllers[index])
            tapHandler()
        }
        childrenControllers.append(tabItem.tabbedVC)
        tabItem.tabIndex = tabItemsArray.count
        tabItemsArray.append(tabItem)
        configureConstraints()
        view.setNeedsLayout()
        view.layoutIfNeeded()
    }
    
    func selectTabItem(index: Int) {
        tabItemsArray[index].tabItemTapHandler?(index)
    }

    
    func presentChildVC(vc: TabbedViewController) {
        
        self.childrenControllers.forEach { (childVC) in
            childVC.view.removeFromSuperview()
            childVC.removeFromParent()
        }
        
        self.addChild(vc)
        self.childrenContainer.addSubview(vc.view)
        
        vc.view.translatesAutoresizingMaskIntoConstraints = false
        vc.view.leadingAnchor.constraint(equalTo: childrenContainer.leadingAnchor).isActive = true
        vc.view.trailingAnchor.constraint(equalTo: childrenContainer.trailingAnchor).isActive = true
        vc.view.topAnchor.constraint(equalTo: childrenContainer.topAnchor).isActive = true
        vc.view.bottomAnchor.constraint(equalTo: childrenContainer.bottomAnchor).isActive = true
    }
    
    
    private func recalcTabConstraints(selectedIndex: Int){
        var selectedTabWidth: CGFloat = tabItemsArray.count == 1 ? self.view.frame.width : (view.frame.width) / CGFloat(tabItemsArray.count) * settings.selectedTabWidthCoef
        var notselectedTabWidth = tabItemsArray.count == 1 ? self.view.frame.width : (view.frame.width - selectedTabWidth)/CGFloat(tabItemsArray.count - 1)
        
        
        selectedTabWidth = selectedTabWidth < settings.minSelectedWidth ? settings.minSelectedWidth : selectedTabWidth
        
        notselectedTabWidth = notselectedTabWidth < settings.minNotselectedWidth ? settings.minNotselectedWidth : notselectedTabWidth
        
        NSLayoutConstraint.deactivate(variableConstraintGroup)
        variableConstraintGroup = []
        for index in 0..<tabItemsArray.count {
            if index == selectedIndex { variableConstraintGroup.append(tabItemsArray[index].widthAnchor.constraint(equalToConstant: selectedTabWidth))
                variableConstraintGroup.append(tabItemsArray[index].topAnchor.constraint(equalTo: tabItemsArray[index].superview!.topAnchor))
            } else {
                variableConstraintGroup.append(tabItemsArray[index].widthAnchor.constraint(equalToConstant: notselectedTabWidth))
                variableConstraintGroup.append(tabItemsArray[index].topAnchor.constraint(equalTo: tabItemsArray[index].superview!.topAnchor, constant: settings.notSelectedTabTopOffset))
            }
        }
        NSLayoutConstraint.activate(variableConstraintGroup)
    }
    
    
    private func configureConstraints() {
        NSLayoutConstraint.deactivate(constantConstraintGroup)
        NSLayoutConstraint.deactivate(variableConstraintGroup)
        
        constantConstraintGroup = []
        variableConstraintGroup = []
        if tabItemsArray.count > 0 {
            
            constantConstraintGroup.append(tabItemsArray[0].leadingAnchor
                .constraint(equalTo: tabItemsArray[0].superview!.leadingAnchor))
            constantConstraintGroup.append(tabItemsArray[tabItemsArray.count - 1].trailingAnchor
                .constraint(equalTo: tabItemsArray[tabItemsArray.count - 1].superview!.trailingAnchor))
            
            for index in 0..<tabItemsArray.count {
                let item = tabItemsArray[index]
                constantConstraintGroup.append(item.bottomAnchor
                    .constraint(equalTo: item.superview!.bottomAnchor))
                if tabItemsArray.indices.contains(index + 1) {
                    constantConstraintGroup.append(tabItemsArray[index].trailingAnchor
                        .constraint(equalTo: tabItemsArray[index + 1].leadingAnchor))
                }
            }
            
            NSLayoutConstraint.activate(constantConstraintGroup)
            
            for index in 0..<tabItemsArray.count {
                variableConstraintGroup.append(tabItemsArray[index].topAnchor
                    .constraint(equalTo: tabItemsArray[index].superview!.topAnchor))
                if tabItemsArray.indices.contains(index + 1) {
                    variableConstraintGroup.append(tabItemsArray[index].widthAnchor
                        .constraint(equalTo: tabItemsArray[index + 1].widthAnchor))
                }
            }
            NSLayoutConstraint.activate(variableConstraintGroup)
        }
    }
    
    private func configureNotselectedContainerView() {
        scrollContainerView.addSubview(notSelectedContainerView)
        notSelectedContainerView.translatesAutoresizingMaskIntoConstraints = false
        notSelectedContainerView.topAnchor.constraint(equalTo: scrollContainerView.topAnchor, constant: settings.notSelectedTabTopOffset).isActive = true
        notSelectedContainerView.leadingAnchor.constraint(equalTo: scrollContainerView.leadingAnchor).isActive = true
        notSelectedContainerView.trailingAnchor.constraint(equalTo: scrollContainerView.trailingAnchor).isActive = true
        notSelectedContainerView.bottomAnchor.constraint(equalTo: scrollContainerView.bottomAnchor).isActive = true
    }
    
    
    private func configureScrollContainer() {
        scrollView.addSubview(scrollContainerView)
        scrollContainerView.translatesAutoresizingMaskIntoConstraints = false
        scrollContainerView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        scrollContainerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        scrollContainerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        scrollContainerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        scrollContainerView.heightAnchor.constraint(equalToConstant: settings.tabMenuHeight).isActive = true
        let widthConstraint = scrollContainerView.widthAnchor.constraint(equalToConstant: 1000)
        widthConstraint.priority = UILayoutPriority(rawValue: 100)
        widthConstraint.isActive = true
    }
    
    private func configureViews() {
        configureScrollView()
        configureScrollContainer()
        configureChildrenContainer()
    }
    
    private func configureScrollView() {
        self.view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        scrollView.heightAnchor.constraint(equalToConstant: settings.tabMenuHeight).isActive = true
    }
    
    
    private func configureChildrenContainer() {
        self.view.addSubview(childrenContainer)
        childrenContainer.translatesAutoresizingMaskIntoConstraints = false
        childrenContainer.topAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        childrenContainer.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        childrenContainer.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        childrenContainer.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
}
