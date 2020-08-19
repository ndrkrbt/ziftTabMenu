//
//  ZiftTabMenuSettings.swift
//  ZiftTabMenu
//
//  Created by Andrey on 19/08/2020.
//  Copyright © 2020 Andrey. All rights reserved.
//

import UIKit

struct ZiftTabMenuSettings {
    let backgroundColor: UIColor
    var selectedTabWidthCoef: CGFloat
    var notSelectedTabTopOffset: CGFloat
    var minSelectedWidth: CGFloat
    var minNotselectedWidth: CGFloat
    
    init(backgroundColor: UIColor = .white, selectedTabWidthCoef: CGFloat = 1.83, notSelectedTabTopOffset: CGFloat = 7, minSelectedWidth: CGFloat = 100, minNotselectedWidth: CGFloat = 40) {
        self.backgroundColor = backgroundColor
        self.selectedTabWidthCoef = selectedTabWidthCoef
        self.notSelectedTabTopOffset = notSelectedTabTopOffset
        self.minSelectedWidth = minSelectedWidth
        self.minNotselectedWidth = minNotselectedWidth
    }
}
