//
//  TabController.swift
//  zift-parent
//
//  Created by Filipp Lebedev on 09.04.2018.
//  Copyright © 2018 ESCape-tech. All rights reserved.
//

import UIKit

class ZiftTabMenuView: UIView {
    
    var settings: ZiftTabMenuSettings
    var tabMenuItemsArray: [ZiftTabMenuItemView] = []
    private var variableConstraintGroup: [NSLayoutConstraint] = []
    private var constantConstraintGroup: [NSLayoutConstraint] = []
    
    lazy var containerView = UIView()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        containerView.layer.cornerRadius = 12
        containerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }

    
    init(settings: ZiftTabMenuSettings) {
        self.settings = settings
        super.init(frame: CGRect.zero)
        configureContainerView()
        containerView.backgroundColor = settings.backgroundColor
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
       
    func addTabMenuItem(tabMenuItem: ZiftTabMenuItemView, tapHandler: @escaping ()->Void) {
        addSubview(tabMenuItem)
        tabMenuItem.tabMenuItemTapHandler = { [weak self] index in
            guard let self = self else {
                return
            }
            self.recalcTabMenuConstraints(selectedIndex: index)
            for item in 0..<self.tabMenuItemsArray.count {
                self.tabMenuItemsArray[item].isSelected = item == index
            }
            tapHandler()
        }
        tabMenuItem.tabMenuIndex = tabMenuItemsArray.count
        tabMenuItemsArray.append(tabMenuItem)
        configureConstraints()
        setNeedsLayout()
        layoutIfNeeded()
    }
    
    func selectTabMenuItem(index: Int) {
        tabMenuItemsArray[index].tabMenuItemTapHandler?(index)
    }
    
    private func recalcTabMenuConstraints(selectedIndex: Int){
        var selectedTabWidth: CGFloat = tabMenuItemsArray.count == 1 ? self.frame.width : (frame.width) / CGFloat(tabMenuItemsArray.count) * settings.selectedTabWidthCoef
        var notselectedTabWidth = tabMenuItemsArray.count == 1 ? self.frame.width : (frame.width - selectedTabWidth)/CGFloat(tabMenuItemsArray.count - 1)
        
        
        selectedTabWidth = selectedTabWidth < settings.minSelectedWidth ? settings.minSelectedWidth : selectedTabWidth
        
        notselectedTabWidth = notselectedTabWidth < settings.notSelectedTabTopOffset ? settings.notSelectedTabTopOffset : notselectedTabWidth
        
        NSLayoutConstraint.deactivate(variableConstraintGroup)
        variableConstraintGroup = []
        for index in 0..<tabMenuItemsArray.count {
            if index == selectedIndex { variableConstraintGroup.append(tabMenuItemsArray[index].widthAnchor.constraint(equalToConstant: selectedTabWidth))
                variableConstraintGroup.append(tabMenuItemsArray[index].topAnchor.constraint(equalTo: tabMenuItemsArray[index].superview!.topAnchor))
            } else {
                if tabMenuItemsArray.indices.contains(index + 1) {
                    variableConstraintGroup.append(tabMenuItemsArray[index].widthAnchor.constraint(equalToConstant: notselectedTabWidth))
                }
                variableConstraintGroup.append(tabMenuItemsArray[index].topAnchor.constraint(equalTo: tabMenuItemsArray[index].superview!.topAnchor, constant: settings.notSelectedTabTopOffset))
            }
        }
        NSLayoutConstraint.activate(variableConstraintGroup)
    }
    
    
    private func configureConstraints() {
        NSLayoutConstraint.deactivate(constantConstraintGroup)
        NSLayoutConstraint.deactivate(variableConstraintGroup)
        
        constantConstraintGroup = []
        variableConstraintGroup = []
        if tabMenuItemsArray.count > 0 {
            
            constantConstraintGroup.append(tabMenuItemsArray[0].leadingAnchor
                .constraint(equalTo: tabMenuItemsArray[0].superview!.leadingAnchor))
            constantConstraintGroup.append(tabMenuItemsArray[tabMenuItemsArray.count - 1].trailingAnchor
                .constraint(equalTo: tabMenuItemsArray[tabMenuItemsArray.count - 1].superview!.trailingAnchor))
            
            for index in 0..<tabMenuItemsArray.count {
                let item = tabMenuItemsArray[index]
                constantConstraintGroup.append(item.bottomAnchor
                    .constraint(equalTo: item.superview!.bottomAnchor))
                if tabMenuItemsArray.indices.contains(index + 1) {
                    constantConstraintGroup.append(tabMenuItemsArray[index].trailingAnchor
                        .constraint(equalTo: tabMenuItemsArray[index + 1].leadingAnchor))
                }
            }
            
            NSLayoutConstraint.activate(constantConstraintGroup)
            
            for index in 0..<tabMenuItemsArray.count {
                variableConstraintGroup.append(tabMenuItemsArray[index].topAnchor
                    .constraint(equalTo: tabMenuItemsArray[index].superview!.topAnchor))
                if tabMenuItemsArray.indices.contains(index + 1) {
                    variableConstraintGroup.append(tabMenuItemsArray[index].widthAnchor
                        .constraint(equalTo: tabMenuItemsArray[index + 1].widthAnchor))
                }
            }
            NSLayoutConstraint.activate(variableConstraintGroup)
        }
    }
    
    private func configureContainerView() {
        self.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.topAnchor.constraint(equalTo: self.topAnchor, constant: settings.notSelectedTabTopOffset).isActive = true
        containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
}
