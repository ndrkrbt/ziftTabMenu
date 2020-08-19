//
//  ZiftTabMenuSettings.swift
//  ZiftTabMenu
//
//  Created by Andrey on 19/08/2020.
//  Copyright © 2020 Andrey. All rights reserved.
//

import UIKit

struct ZiftTabMenuItemSettings {
    let id: String
    let title: String
    var titleColor: UIColor
    var titleOffset: UIEdgeInsets
    var titleAligment: NSTextAlignment
    let iconImage: UIImage
    var selectedIconOffset: UIEdgeInsets
    var unselectedIconOffset: UIEdgeInsets
    var selectedMeneItemBackground: UIColor
    var menuItemShadowColor: CGColor
    var menuItemShadowRadius: CGFloat
    var menuItemShadowOpacity: Float
    var menuItemShadowOffset: CGSize
    var selectedIconTintColor: UIColor
    var selectedIconAlpha: CGFloat
    var unselectedIconTintColor: UIColor
    var unselectedIconAlpha: CGFloat
    var unselectedMeneItemBackground: UIColor
    
    init(id: String, title: String, titleColor: UIColor = .ziftSelectedTabTitle ,titleOffset: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), titleAligment: NSTextAlignment = .left, iconImage: UIImage, selectedIconOffset: UIEdgeInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: -5), unselectedIconOffset: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), selectedMeneItemBackground: UIColor = .white, menuItemShadowColor: CGColor = UIColor.black.cgColor, menuItemShadowRadius: CGFloat = 6.0, menuItemShadowOpacity: Float = 0.18 ,menuItemShadowOffset: CGSize = CGSize(width: 0, height: 3), selectedIconTintColor: UIColor = .ziftSelectedTabTitle, selectedIconAlpha: CGFloat = 1, unselectedIconTintColor: UIColor = .black, unselectedIconAlpha: CGFloat = 0.4, unselectedMeneItemBackground: UIColor = .clear) {
        self.id = id
        self.title = title
        self.titleColor = titleColor
        self.titleOffset = titleOffset
        self.titleAligment = titleAligment
        self.iconImage = iconImage
        self.selectedIconOffset = selectedIconOffset
        self.unselectedIconOffset = unselectedIconOffset
        self.selectedMeneItemBackground = selectedMeneItemBackground
        self.menuItemShadowColor = menuItemShadowColor
        self.menuItemShadowRadius = menuItemShadowRadius
        self.menuItemShadowOpacity = menuItemShadowOpacity
        self.menuItemShadowOffset = menuItemShadowOffset
        self.selectedIconTintColor = selectedIconTintColor
        self.selectedIconAlpha = selectedIconAlpha
        self.unselectedIconTintColor = unselectedIconTintColor
        self.unselectedIconAlpha = unselectedIconAlpha
        self.unselectedMeneItemBackground = unselectedMeneItemBackground
    }
}
