//
//  TabController.swift
//  zift-parent
//
//  Created by Filipp Lebedev on 09.04.2018.
//  Copyright © 2018 ESCape-tech. All rights reserved.
//

import UIKit

class ZiftTabMenuView: UIView {
    
    var selectedTabWidthCoef: CGFloat = 1.83
    var notSelectedTabTopOffset: CGFloat = 7
    
    var tabMenuItemsArray: [ZiftTabMenuItemView] = []
    var variableConstraintGroup: [NSLayoutConstraint] = []
    var constantConstraintGroup: [NSLayoutConstraint] = []
    
    @IBOutlet weak var containerView: UIView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        containerView.roundCorners([.topLeft, .topRight], radius: 12)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func addTabMenuItem(title: String,
                        icon: UIImage?,
                        id: String,
                        selectedTabTitleColor: UIColor = .ziftSelectedTabTitle,
                        tapHandler: @escaping ()->Void) {
        let tabMenuItem = ZiftTabMenuItemView.fromNib()
        tabMenuItem.configureView(title: title, icon: icon, id: id, tabMenuIndex: tabMenuItemsArray.count, selectedTabTitleColor: selectedTabTitleColor)
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
        tabMenuItemsArray.append(tabMenuItem)
        configureConstraints()
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    
    func selectTabMenuItem(index: Int) {
        tabMenuItemsArray[index].tabMenuItemTapHandler(index)
    }
    
    func configure(backgroundColor: UIColor = .white, selectedTabWidthCoef: CGFloat = 1.83, notSelectedTabTopOffset: CGFloat = 7) {
        containerView.backgroundColor = backgroundColor
        self.selectedTabWidthCoef = selectedTabWidthCoef
        self.notSelectedTabTopOffset = notSelectedTabTopOffset
    }
    
    func recalcTabMenuConstraints(selectedIndex: Int){
        let selectedTabWidth: CGFloat = tabMenuItemsArray.count == 1 ? self.frame.width : (frame.width) / CGFloat(tabMenuItemsArray.count) * selectedTabWidthCoef
        let notselectedTabWidth = tabMenuItemsArray.count == 1 ? self.frame.width : (frame.width - selectedTabWidth)/CGFloat(tabMenuItemsArray.count - 1)
        
        NSLayoutConstraint.deactivate(variableConstraintGroup)
        
        variableConstraintGroup = []
        for index in 0..<tabMenuItemsArray.count {
            if index == selectedIndex { variableConstraintGroup.append(tabMenuItemsArray[index].widthAnchor.constraint(equalToConstant: selectedTabWidth))
                variableConstraintGroup.append(tabMenuItemsArray[index].topAnchor.constraint(equalTo: tabMenuItemsArray[index].superview!.topAnchor))
            } else {
                if tabMenuItemsArray.indices.contains(index + 1) {
                    variableConstraintGroup.append(tabMenuItemsArray[index].widthAnchor.constraint(equalToConstant: notselectedTabWidth))
                }
                variableConstraintGroup.append(tabMenuItemsArray[index].topAnchor.constraint(equalTo: tabMenuItemsArray[index].superview!.topAnchor, constant: notSelectedTabTopOffset))
            }
        }
        NSLayoutConstraint.activate(variableConstraintGroup)
    }
    
    func configureConstraints() {
        
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
}
