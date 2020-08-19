//
//  ZiftTabMenuItemView.swift
//  zift-parent
//
//  Created by Andrey on 13/12/2018.
//  Copyright © 2018 ESCape-tech. All rights reserved.
//

import UIKit

class ZiftTabMenuItemView: UIView {

    lazy var containerView = UIView()
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fill
        return stack
    }()
    lazy var iconContainerView = UIView()
    
    lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .center
        imageView.image = settings.iconImage
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = settings.titleFont
        label.textColor = settings.titleColor
        label.textAlignment = settings.titleAligment
        return label
    }()
   
    lazy var titleContainerView = UIView()
   
    lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("", for: .normal)
        button.addTarget(self, action: #selector(buttonTapHandler(_:)), for: .touchUpInside)
        return button
    }()
    
    private var selectedTabConstraintGroup: [NSLayoutConstraint] = []
    private var unselectedTabConstraintGroup: [NSLayoutConstraint] = []
    var tabMenuItemTapHandler: ((Int) -> Void)?
    var settings: ZiftTabMenuItemSettings
    var tabMenuIndex: Int = 0
    
    var isSelected = false {
        didSet {
            if isSelected {
                containerView.backgroundColor = settings.selectedMeneItemBackground
                layer.shadowColor = settings.menuItemShadowColor
                layer.shadowRadius = settings.menuItemShadowRadius
                layer.shadowOpacity = settings.menuItemShadowOpacity
                layer.shadowOffset = settings.menuItemShadowOffset
                iconImageView.tintColor = settings.selectedIconTintColor
                iconImageView.alpha = settings.selectedIconAlpha
            } else {
                iconImageView.tintColor = settings.unselectedIconTintColor
                iconImageView.alpha = settings.unselectedIconAlpha
                layer.shadowOpacity = settings.menuItemShadowOpacity
                containerView.backgroundColor = settings.unselectedMeneItemBackground
            }
            configureIconImageViewConstraints(isSelected)
            titleContainerView.isHidden = !isSelected
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        containerView.layer.cornerRadius = 12
        containerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    init(settings: ZiftTabMenuItemSettings) {
        self.settings = settings
        super.init(frame: CGRect.zero)
        configureContainerView()
        configureConstraintGroups()
       configureTitle(title: settings.title)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureIconImageViewConstraints(_ isSelected: Bool) {
        if isSelected {
            NSLayoutConstraint.deactivate(unselectedTabConstraintGroup)
            NSLayoutConstraint.activate(selectedTabConstraintGroup)
        }
        else {
            NSLayoutConstraint.deactivate(selectedTabConstraintGroup)
            NSLayoutConstraint.activate(unselectedTabConstraintGroup)
        }
    }
    
    private func configureConstraintGroups(){
        selectedTabConstraintGroup = [
            iconImageView.leadingAnchor.constraint(equalTo: iconImageView.superview!.leadingAnchor, constant: settings.selectedIconOffset.left),
            iconImageView.trailingAnchor.constraint(equalTo: iconImageView.superview!.trailingAnchor, constant: settings.selectedIconOffset.right),
            iconImageView.topAnchor.constraint(equalTo: iconImageView.superview!.topAnchor, constant: settings.selectedIconOffset.top),
            iconImageView.bottomAnchor.constraint(equalTo: iconImageView.superview!.bottomAnchor, constant: settings.selectedIconOffset.bottom)
        ]
        
        unselectedTabConstraintGroup = [
            iconImageView.leadingAnchor.constraint(equalTo: iconImageView.superview!.leadingAnchor, constant: settings.unselectedIconOffset.left),
            iconImageView.trailingAnchor.constraint(equalTo: iconImageView.superview!.trailingAnchor, constant: settings.unselectedIconOffset.right),
            iconImageView.topAnchor.constraint(equalTo: iconImageView.superview!.topAnchor, constant: settings.unselectedIconOffset.top),
            iconImageView.bottomAnchor.constraint(equalTo: iconImageView.superview!.bottomAnchor, constant: settings.unselectedIconOffset.bottom)
        ]
    }
    
    private func configureTitle(title: String){
        titleLabel.text = title
    }
    
    @objc func buttonTapHandler(_ sender: UIButton) {
        tabMenuItemTapHandler?(tabMenuIndex)
    }
    
    private func configureContainerView() {
        self.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        configureStackView()
        configureStackContainers()
        configureButton()
    }
    
    private func configureStackView() {
        containerView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: stackView.superview!.topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: stackView.superview!.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: stackView.superview!.trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: stackView.superview!.bottomAnchor).isActive = true
    }
    
    private func configureStackContainers() {
        stackView.addArrangedSubview(iconContainerView)
        stackView.addArrangedSubview(titleContainerView)
        iconContainerView.translatesAutoresizingMaskIntoConstraints = false
        titleContainerView.translatesAutoresizingMaskIntoConstraints = false
        titleContainerView.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: titleLabel.superview!.topAnchor, constant: settings.titleOffset.top).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: titleLabel.superview!.leadingAnchor, constant: settings.titleOffset.left).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: titleLabel.superview!.trailingAnchor, constant: settings.titleOffset.right).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: titleLabel.superview!.bottomAnchor, constant: settings.titleOffset.bottom).isActive = true
        
        iconContainerView.addSubview(iconImageView)
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.setContentHuggingPriority(UILayoutPriority(rawValue: 751), for: .horizontal)
    }
    
    private func configureButton() {
        self.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        button.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        button.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
}
