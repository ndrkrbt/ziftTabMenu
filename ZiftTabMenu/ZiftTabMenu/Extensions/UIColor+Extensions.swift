//
//  UIColor+Extensions.swift
//  ZiftTabMenu
//
//  Created by Andrey on 14/08/2020.
//  Copyright © 2020 Andrey. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        let newRed = CGFloat(red)/255
        let newGreen = CGFloat(green)/255
        let newBlue = CGFloat(blue)/255
        
        self.init(red: newRed, green: newGreen, blue: newBlue, alpha: 1.0)
    }
    
    class func random() -> UIColor{
        return UIColor(
            red: Int(arc4random_uniform(255)),
            green: Int(arc4random_uniform(255)),
            blue: Int(arc4random_uniform(255))
        )
    }
    
    // MARK: HEX support
    convenience init?(hex: String){
        var hexString = hex
        
        if hexString.hasPrefix("#"){
            hexString = hexString.right(hexString.count - 1)
        }
        
        guard hexString.count == 6 else { return nil }
        
        var components: [Int] = []
        for i in 0..<3{
            let startIndex = hexString.index(hexString.startIndex, offsetBy: i * 2)
            let endIndex = hexString.index(hexString.startIndex, offsetBy: (i+1) * 2)
            let r = startIndex..<endIndex
            let subString = hexString.substring(with: r)
            let scanner = Scanner(string: subString)
            
            var scannedValue: UInt32 = 0
            guard scanner.scanHexInt32(&scannedValue) else { break }
            guard scannedValue >= 0 && scannedValue <= 255 else { break }
            components.append(Int(scannedValue))
        }
        guard components.count == 3 else { return nil }
        
        self.init(red: components[0], green: components[1], blue: components[2])
    }
    
    var hexString: String?{
        var red: CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat = 0.0
        
        guard getRed(&red, green: &green, blue: &blue, alpha: nil) else { return nil }
        
        var result = "#"
        for v in [red, green, blue]{
            let intValue = Int(v * 255)
            result += String(format: "%02X", intValue)
        }
        return result
    }
}
