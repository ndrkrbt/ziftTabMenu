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
        configureSegmentViewConstraints()
        configureSegmentItems()
    }
    
    var segmentView = ChildScreenSegmentView.fromNib()
    
    func configureSegmentViewConstraints() {
        view.addSubview(segmentView)
        
        segmentView.translatesAutoresizingMaskIntoConstraints = false
        segmentView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        segmentView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        segmentView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        segmentView.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
    func configureSegmentItems() {
        segmentView.addSegmentItem(title: "Searches", icon: UIImage(named: "SearchesTabIcon"), id: "Searches") { [weak self] in
            self?.segmentSelectedHandler()
        }

        segmentView.addSegmentItem(title: "Screentime", icon: UIImage(named: "SearchesTabIcon"), id: "Screentime") { [weak self] in
            self?.segmentSelectedHandler()
        }

        segmentView.addSegmentItem(title: "Blocks & Alerts", icon: UIImage(named: "SearchesTabIcon"), id: "Blocks") { [weak self] in
            self?.segmentSelectedHandler()
        }

        segmentView.addSegmentItem(title: "YouTube", icon: UIImage(named: "SearchesTabIcon"), id: "YouTube") { [weak self] in
            self?.segmentSelectedHandler()
        }

        segmentView.addSegmentItem(title: "Location", icon: UIImage(named: "SearchesTabIcon"), id: "Location") { [weak self] in
            self?.segmentSelectedHandler()
        }
        
        segmentView.selectSegmentByIndex(0)
    }
    
    func segmentSelectedHandler() {
        guard let selectedItemSegment = segmentView.segmentItemArray.filter({$0.isSelected}).first else {
            return
        }
        
        print(selectedItemSegment.id)
    }
}

