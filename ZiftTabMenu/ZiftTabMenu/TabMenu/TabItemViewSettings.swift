//
//  TabSettings.swift
//
//  Created by Andrey on 19/08/2020.
//  Copyright © 2020 Andrey. All rights reserved.
//

import UIKit

struct TabItemViewSettings {
    var titleColor: UIColor
    var tabItemLayoutSettings: TabItemViewLayoutSettings
    var titleAligment: NSTextAlignment
    var titleFont: UIFont
    var selectedMeneItemBackground: UIColor
    var tabItemShadowColor: CGColor
    var tabItemShadowRadius: CGFloat
    var tabItemShadowOpacity: Float
    var tabItemShadowOffset: CGSize
    var selectedIconTintColor: UIColor
    var selectedIconAlpha: CGFloat
    var unselectedIconTintColor: UIColor
    var unselectedIconAlpha: CGFloat
    var unselectedMeneItemBackground: UIColor
    
    init(titleColor: UIColor = .ziftSelectedTabTitle,
         tabItemLayoutSettings: TabItemViewLayoutSettings = TabItemViewLayoutSettings(),
         titleAligment: NSTextAlignment = .left,
         titleFont: UIFont = .systemFont(ofSize: 14),
         selectedMeneItemBackground: UIColor = .white,
         tabItemShadowColor: CGColor = UIColor.black.cgColor,
         tabItemShadowRadius: CGFloat = 6.0,
         tabItemShadowOpacity: Float = 0.18,
         tabItemShadowOffset: CGSize = CGSize(width: 0, height: 3),
         selectedIconTintColor: UIColor = .ziftSelectedTabTitle,
         selectedIconAlpha: CGFloat = 1,
         unselectedIconTintColor: UIColor = .black,
         unselectedIconAlpha: CGFloat = 0.4,
         unselectedMeneItemBackground: UIColor = .clear) {
        
        self.titleColor = titleColor
        self.tabItemLayoutSettings = tabItemLayoutSettings
        self.titleAligment = titleAligment
        self.titleFont = titleFont
        self.selectedMeneItemBackground = selectedMeneItemBackground
        self.tabItemShadowColor = tabItemShadowColor
        self.tabItemShadowRadius = tabItemShadowRadius
        self.tabItemShadowOpacity = tabItemShadowOpacity
        self.tabItemShadowOffset = tabItemShadowOffset
        self.selectedIconTintColor = selectedIconTintColor
        self.selectedIconAlpha = selectedIconAlpha
        self.unselectedIconTintColor = unselectedIconTintColor
        self.unselectedIconAlpha = unselectedIconAlpha
        self.unselectedMeneItemBackground = unselectedMeneItemBackground
    }
}

struct TabItemViewLayoutSettings {
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
