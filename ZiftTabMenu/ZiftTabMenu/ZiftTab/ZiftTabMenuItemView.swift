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
        label.font = .systemFont(ofSize: 14)
        label.textColor = .ziftSelectedTabTitle
        label.textAlignment = .left
        return label
    }()
    lazy var titleContainerView = UIView()
    lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("", for: .normal)
        button.addTarget(self, action: #selector(buttonTapHandler(_:)), for: .touchUpInside)
        return button
    }()
    
    var selectedTabConstraintGroup: [NSLayoutConstraint] = []
    var unselectedTabConstraintGroup: [NSLayoutConstraint] = []
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
        containerView.roundCorners([.topLeft, .topRight], radius: 12)
    }
    
    init(settings: ZiftTabMenuItemSettings) {
        self.settings = settings
        super.init(frame: CGRect.zero)
        configureContainerView()
        configureConstraintGroups()
        configureTitle(title: settings.title, titleColor: settings.titleColor, aligment: settings.titleAligment)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureIconImageViewConstraints(_ isSelected: Bool) {
        if isSelected {
            NSLayoutConstraint.deactivate(unselectedTabConstraintGroup)
            NSLayoutConstraint.activate(selectedTabConstraintGroup)
        }
        else {
            NSLayoutConstraint.deactivate(selectedTabConstraintGroup)
            NSLayoutConstraint.activate(unselectedTabConstraintGroup)
        }
    }
    
    func configureConstraintGroups(){
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
    
    func configureTitle(title: String, titleColor: UIColor = .ziftSelectedTabTitle, aligment: NSTextAlignment){
        titleLabel.text = title
        titleLabel.textColor = titleColor
        titleLabel.textAlignment = aligment
    }
                        
    
    @objc func buttonTapHandler(_ sender: UIButton) {
        tabMenuItemTapHandler?(tabMenuIndex)
    }
    
    
    func configureContainerView() {
        self.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        configureStackView()
        configureStackContainers()
    }
    
    func configureStackView() {
        self.containerView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: stackView.superview!.topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: stackView.superview!.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: stackView.superview!.trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: stackView.superview!.bottomAnchor).isActive = true
    }
    
    func configureStackContainers() {
        self.stackView.addArrangedSubview(iconContainerView)
        
        self.stackView.addArrangedSubview(titleContainerView)
        iconContainerView.translatesAutoresizingMaskIntoConstraints = false
        titleContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        
        self.titleContainerView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: titleLabel.superview!.topAnchor, constant: settings.titleOffset.top).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: titleLabel.superview!.leadingAnchor, constant: settings.titleOffset.left).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: titleLabel.superview!.trailingAnchor, constant: settings.titleOffset.right).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: titleLabel.superview!.bottomAnchor, constant: settings.titleOffset.bottom).isActive = true
        
        self.iconContainerView.addSubview(iconImageView)
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.setContentHuggingPriority(UILayoutPriority(rawValue: 751), for: .horizontal)
        
        self.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        button.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        button.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
               
    }
}

struct ZiftTabMenuItemSettings {
    let id: String
    let title: String
    let titleColor: UIColor = .ziftSelectedTabTitle
    let titleOffset: Offset = Offset(top: 0, bottom: 0, left: 0, right: 0)
    let titleAligment: NSTextAlignment = .left
    let iconImage: UIImage
    let selectedIconOffset: Offset = Offset(top: 0, bottom: 0, left: 15, right: -5)
    let unselectedIconOffset: Offset = Offset(top: 0, bottom: 0, left: 0, right: 0)
    let selectedMeneItemBackground: UIColor = .white
    let menuItemShadowColor: CGColor = UIColor.black.cgColor
    let menuItemShadowRadius: CGFloat = 6.0
    let menuItemShadowOpacity: Float = 0.18
    let menuItemShadowOffset: CGSize = CGSize(width: 0, height: 3)
    let selectedIconTintColor: UIColor = .ziftSelectedTabTitle
    let selectedIconAlpha: CGFloat = 1
    let unselectedIconTintColor: UIColor = .black
    let unselectedIconAlpha: CGFloat = 0.4
    let unselectedMeneItemBackground: UIColor = .clear
}

struct Offset {
    let top: CGFloat
    let bottom: CGFloat
    let left: CGFloat
    let right: CGFloat
}
