//
//  TabItemView.swift
//
//
//  Created by Andrey on 13/12/2018.
//  Copyright © 2018 ESCape-tech. All rights reserved.
//

import UIKit

class TabItemView: UIView {

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
        imageView.image = iconImage
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = settings.titleFont
        label.textColor = settings.titleColor
        label.textAlignment = settings.titleAligment
        label.text = title
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
    
    var id: String
    var title: String
    var iconImage: UIImage
    var tabItemTapHandler: ((Int) -> Void)?
    var settings: TabItemViewSettings
    var tabIndex: Int = 0
    var layoutSettings: TabItemViewLayoutSettings
    
    var isSelected = false {
        didSet {
            if isSelected {
                containerView.backgroundColor = settings.selectedMeneItemBackground
                layer.shadowColor = settings.tabItemShadowColor
                layer.shadowRadius = settings.tabItemShadowRadius
                layer.shadowOpacity = settings.tabItemShadowOpacity
                layer.shadowOffset = settings.tabItemShadowOffset
                iconImageView.tintColor = settings.selectedIconTintColor
                iconImageView.alpha = settings.selectedIconAlpha
            } else {
                iconImageView.tintColor = settings.unselectedIconTintColor
                iconImageView.alpha = settings.unselectedIconAlpha
                layer.shadowOpacity = settings.tabItemShadowOpacity
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
    
    init(settings: TabItemViewSettings, id: String, title: String, iconImage: UIImage) {
        self.id = id
        self.title = title
        self.iconImage = iconImage
        self.settings = settings
        self.layoutSettings = settings.tabItemLayoutSettings
        super.init(frame: CGRect.zero)
        configureContainerView()
        configureConstraintGroups()
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
            iconImageView.leadingAnchor.constraint(equalTo: iconImageView.superview!.leadingAnchor, constant: layoutSettings.selectedIconOffset.left),
            iconImageView.trailingAnchor.constraint(equalTo: iconImageView.superview!.trailingAnchor, constant: layoutSettings.selectedIconOffset.right),
            iconImageView.topAnchor.constraint(equalTo: iconImageView.superview!.topAnchor, constant: layoutSettings.selectedIconOffset.top),
            iconImageView.bottomAnchor.constraint(equalTo: iconImageView.superview!.bottomAnchor, constant: layoutSettings.selectedIconOffset.bottom)
        ]
        
        unselectedTabConstraintGroup = [
            iconImageView.leadingAnchor.constraint(equalTo: iconImageView.superview!.leadingAnchor, constant: layoutSettings.unselectedIconOffset.left),
            iconImageView.trailingAnchor.constraint(equalTo: iconImageView.superview!.trailingAnchor, constant: layoutSettings.unselectedIconOffset.right),
            iconImageView.topAnchor.constraint(equalTo: iconImageView.superview!.topAnchor, constant: layoutSettings.unselectedIconOffset.top),
            iconImageView.bottomAnchor.constraint(equalTo: iconImageView.superview!.bottomAnchor, constant: layoutSettings.unselectedIconOffset.bottom)
        ]
    }
    
    @objc func buttonTapHandler(_ sender: UIButton) {
        tabItemTapHandler?(tabIndex)
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
        titleLabel.topAnchor.constraint(equalTo: titleLabel.superview!.topAnchor, constant: layoutSettings.titleOffset.top).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: titleLabel.superview!.leadingAnchor, constant: layoutSettings.titleOffset.left).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: titleLabel.superview!.trailingAnchor, constant: layoutSettings.titleOffset.right).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: titleLabel.superview!.bottomAnchor, constant: layoutSettings.titleOffset.bottom).isActive = true
        
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
