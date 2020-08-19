//
//  ZiftTabMenuSettings.swift
//  ZiftTabMenu
//
//  Created by Andrey on 19/08/2020.
//  Copyright © 2020 Andrey. All rights reserved.
//

import UIKit

struct ZiftTabMenuItemSettings {
    var titleColor: UIColor
    var menuItemLayoutSettings: ZiftTabMenuItemLayoutSettings
    var titleAligment: NSTextAlignment
    var titleFont: UIFont
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
    
    init(titleColor: UIColor = .ziftSelectedTabTitle,
         menuItemLayoutSettings: ZiftTabMenuItemLayoutSettings = ZiftTabMenuItemLayoutSettings(),
         titleAligment: NSTextAlignment = .left,
         titleFont: UIFont = .systemFont(ofSize: 14),
         selectedMeneItemBackground: UIColor = .white,
         menuItemShadowColor: CGColor = UIColor.black.cgColor,
         menuItemShadowRadius: CGFloat = 6.0,
         menuItemShadowOpacity: Float = 0.18,
         menuItemShadowOffset: CGSize = CGSize(width: 0, height: 3),
         selectedIconTintColor: UIColor = .ziftSelectedTabTitle,
         selectedIconAlpha: CGFloat = 1,
         unselectedIconTintColor: UIColor = .black,
         unselectedIconAlpha: CGFloat = 0.4,
         unselectedMeneItemBackground: UIColor = .clear) {
        
        self.titleColor = titleColor
        self.menuItemLayoutSettings = menuItemLayoutSettings
        self.titleAligment = titleAligment
        self.titleFont = titleFont
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

struct ZiftTabMenuItemLayoutSettings {
    var titleOffset: UIEdgeInsets
    var selectedIconOffset: UIEdgeInsets
    var unselectedIconOffset: UIEdgeInsets
    
    init(titleOffset: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0),
         selectedIconOffset: UIEdgeInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: -5),
         unselectedIconOffset: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)) {
        self.titleOffset = titleOffset
        self.selectedIconOffset = selectedIconOffset
        self.unselectedIconOffset = unselectedIconOffset
    }
}
