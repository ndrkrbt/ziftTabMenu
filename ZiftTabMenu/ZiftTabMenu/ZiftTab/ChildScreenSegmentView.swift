//
//  TabController.swift
//  zift-parent
//
//  Created by Filipp Lebedev on 09.04.2018.
//  Copyright © 2018 ESCape-tech. All rights reserved.
//

import UIKit


class ChildScreenSegmentView: UIView {
    
    var notSelectedTabTopOffset: CGFloat = 7
    @IBOutlet weak var containerView: UIView!
    var selectedTabWidthCoef: CGFloat = 1.83
    
    
    var segmentItemArray: [ChildScreenSegmentItemView] = []
    var varGroup: [NSLayoutConstraint] = []
    var constGroup: [NSLayoutConstraint] = []

    override func layoutSubviews() {
        super.layoutSubviews()
        containerView.roundCorners([.topLeft, .topRight], radius: 12)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.translatesAutoresizingMaskIntoConstraints = false
        configureSegmentBackground()
    }
    
    
    func addSegmentItem(title: String, icon: UIImage?, id: String, tapHandler: @escaping ()->Void) {
        let segmentItem = ChildScreenSegmentItemView.fromNib()
        segmentItem.configureView(title: title, icon: icon)
        segmentItem.id = id
        segmentItem.segmentIndex = segmentItemArray.count
        addSubview(segmentItem)
        segmentItem.segmentTapHandler = { [weak self] index in
            guard let self = self else {
                return
            }
            self.recalcSegmentConstraints(selectedIndex: index)
            for item in 0..<self.segmentItemArray.count {
                self.segmentItemArray[item].isSelected = item == index
            }
            tapHandler()
        }
        segmentItemArray.append(segmentItem)
        
        configureSegmentItemViewsConstraints()
        
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    
    func selectSegmentByIndex(_ index: Int) {
        segmentItemArray[index].segmentTapHandler(index)
    }
    
    func configureSegmentBackground(color: UIColor = .white) {
        containerView.backgroundColor = color
    }
    
    
    func recalcSegmentConstraints(selectedIndex: Int){
        print(selectedIndex)
        let selectedWidth: CGFloat = segmentItemArray.count == 1 ? self.frame.width : (frame.width) / CGFloat(segmentItemArray.count) * selectedTabWidthCoef
        let notSelectedWidth = segmentItemArray.count == 1 ? self.frame.width : (frame.width - selectedWidth)/CGFloat(segmentItemArray.count - 1)

        NSLayoutConstraint.deactivate(varGroup)

        varGroup = []
        for index in 0..<segmentItemArray.count {
            if index == selectedIndex { varGroup.append(segmentItemArray[index].widthAnchor.constraint(equalToConstant: selectedWidth))
                varGroup.append(segmentItemArray[index].topAnchor.constraint(equalTo: segmentItemArray[index].superview!.topAnchor))
            } else {
                if segmentItemArray.indices.contains(index + 1) {
                    varGroup.append(segmentItemArray[index].widthAnchor.constraint(equalToConstant: notSelectedWidth))
                }
                varGroup.append(segmentItemArray[index].topAnchor.constraint(equalTo: segmentItemArray[index].superview!.topAnchor, constant: notSelectedTabTopOffset))
            }
        }
        NSLayoutConstraint.activate(varGroup)
    }
    
    func configureSegmentItemViewsConstraints() {
        
         NSLayoutConstraint.deactivate(constGroup)
         NSLayoutConstraint.deactivate(varGroup)
        
        constGroup = []
        varGroup = []
         if segmentItemArray.count > 0 {
           
            constGroup.append(segmentItemArray[0].leadingAnchor.constraint(equalTo: segmentItemArray[0].superview!.leadingAnchor))
            
         
            constGroup.append(segmentItemArray[segmentItemArray.count - 1].trailingAnchor.constraint(equalTo: segmentItemArray[segmentItemArray.count - 1].superview!.trailingAnchor))
            
            
            for index in 0..<segmentItemArray.count {
                let item = segmentItemArray[index]
                constGroup.append(item.bottomAnchor.constraint(equalTo: item.superview!.bottomAnchor))
                if segmentItemArray.indices.contains(index + 1) {
                    constGroup.append(segmentItemArray[index].trailingAnchor.constraint(equalTo: segmentItemArray[index + 1].leadingAnchor))
                }
            }
            
           
            NSLayoutConstraint.activate(constGroup)
            
           
            
            for index in 0..<segmentItemArray.count {
                varGroup.append(segmentItemArray[index].topAnchor.constraint(equalTo: segmentItemArray[index].superview!.topAnchor))
                if segmentItemArray.indices.contains(index + 1) {
                    varGroup.append(segmentItemArray[index].widthAnchor.constraint(equalTo: segmentItemArray[index + 1].widthAnchor))
                }
            }
            NSLayoutConstraint.activate(varGroup)
        }
    }
}
