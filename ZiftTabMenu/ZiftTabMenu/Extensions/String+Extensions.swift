//
//  String+Extensions.swift
//  ZiftTabMenu
//
//  Created by Andrey on 14/08/2020.
//  Copyright © 2020 Andrey. All rights reserved.
//

import Foundation

extension String{
    func right(_ count: Int) -> String{
        var c = max(count, 0)
        c = min(c, self.count)
        let index = self.index(self.endIndex, offsetBy: -1 * c)
        return self.substring(from: index)
    }
}
