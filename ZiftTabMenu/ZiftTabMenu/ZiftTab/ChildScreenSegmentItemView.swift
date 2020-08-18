//
//  ChildScreenSegmentItemView.swift
//  zift-parent
//
//  Created by Andrey on 13/12/2018.
//  Copyright © 2018 ESCape-tech. All rights reserved.
//

import UIKit

class ChildScreenSegmentItemView: UIView {

    @IBOutlet weak var backgroundViewContainer: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleLabelContainer: UIView!
    
    var selectedConstraintGroup: [NSLayoutConstraint] = []
    var unSelectedConstraintGroup: [NSLayoutConstraint] = []
    
    var id: String = ""
    var segmentTapHandler: ((Int) -> Void)!
    var segmentIndex: Int = 0
    
    var isSelected = false {
        didSet {
            if isSelected {
                backgroundViewContainer.backgroundColor = .white
                layer.shadowColor = UIColor.black.cgColor
                layer.shadowRadius = 6.0
                layer.shadowOpacity = 0.18
                layer.shadowOffset = CGSize(width: 0, height: 3)
                iconImageView.tintColor = .ziftSelectedTabTitle
                iconImageView.alpha = 1
            } else {
                iconImageView.tintColor = .black
                iconImageView.alpha = 0.4
                layer.shadowOpacity = 0
                backgroundViewContainer.backgroundColor = .clear
            }
            configureIconImageViewConstraints(isSelected)
            titleLabelContainer.isHidden = !isSelected
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundViewContainer.roundCorners([.topLeft, .topRight], radius: 12)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.translatesAutoresizingMaskIntoConstraints = false
        configureConstraintGroups()
    }
    
    func configureIconImageViewConstraints(_ isSelected: Bool) {
        if isSelected {
            NSLayoutConstraint.deactivate(unSelectedConstraintGroup)
            NSLayoutConstraint.activate(selectedConstraintGroup)
        }
        else {
            NSLayoutConstraint.deactivate(selectedConstraintGroup)
            NSLayoutConstraint.activate(unSelectedConstraintGroup)
        }
    }
    
    func configureConstraintGroups(){
        selectedConstraintGroup = [
            iconImageView.leadingAnchor.constraint(equalTo: iconImageView.superview!.leadingAnchor, constant: 15),
            iconImageView.trailingAnchor.constraint(equalTo: iconImageView.superview!.trailingAnchor, constant: -5)
        ]
        
        unSelectedConstraintGroup = [
            iconImageView.leadingAnchor.constraint(equalTo: iconImageView.superview!.leadingAnchor),
            iconImageView.trailingAnchor.constraint(equalTo: iconImageView.superview!.trailingAnchor)
        ]
    }
    
    func configureView(title: String, icon: UIImage?) {
        titleLabel.text = title
        guard let icon = icon else {
            return
        }
        iconImageView.image = icon.withRenderingMode(.alwaysTemplate)
    }
    
    
    @IBAction func buttonTapped(_ sender: Any) {
        segmentTapHandler(segmentIndex)
    }
}
