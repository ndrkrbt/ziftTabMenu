//
//  TabView.swift
//
//
//  Created by Filipp Lebedev on 09.04.2018.
//  Copyright © 2018 ESCape-tech. All rights reserved.
//

import UIKit

class TabView: UIView {
    
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        notSelectedContainerView.layer.cornerRadius = 12
        notSelectedContainerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }

    
    init(settings: TabViewSettings) {
        self.settings = settings
        super.init(frame: CGRect.zero)
        configureScrollView()
        configureNotselectedContainerView()
        notSelectedContainerView.backgroundColor = settings.backgroundColor
        translatesAutoresizingMaskIntoConstraints = false
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
            tapHandler()
        }
        tabItem.tabIndex = tabItemsArray.count
        tabItemsArray.append(tabItem)
        configureConstraints()
        setNeedsLayout()
        layoutIfNeeded()
    }
    
    func selectTabItem(index: Int) {
        tabItemsArray[index].tabItemTapHandler?(index)
    }
    
    private func recalcTabConstraints(selectedIndex: Int){
        var selectedTabWidth: CGFloat = tabItemsArray.count == 1 ? self.frame.width : (frame.width) / CGFloat(tabItemsArray.count) * settings.selectedTabWidthCoef
        var notselectedTabWidth = tabItemsArray.count == 1 ? self.frame.width : (frame.width - selectedTabWidth)/CGFloat(tabItemsArray.count - 1)
        
        
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
        scrollContainerView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        let widthConstraint = scrollContainerView.widthAnchor.constraint(equalToConstant: 1000)
        widthConstraint.priority = UILayoutPriority(rawValue: 100)
        widthConstraint.isActive = true
    }
    
    
    private func configureScrollView() {
        self.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        configureScrollContainer()
    }
}
