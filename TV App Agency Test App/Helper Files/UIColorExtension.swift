//
//  UIColorExtension.swift
//  TV App Agency Test App
//
//  Created by Shyam Bhudia on 28/04/2016.
//  Copyright © 2016 Shyam. All rights reserved.
//

import UIKit

extension UIColor {
    //Hex to rgb converter
    public convenience init(hex: UInt) {
        self.init(hex: hex, alpha: 1)
    }
    public convenience init(hex: UInt, alpha: CGFloat) {
        let b = (hex >> 0)  & 0xFF
        let g = (hex >> 8)  & 0xFF
        let r = (hex >> 16) & 0xFF
        
        self.init(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: alpha)
    }
}


// Colour literals -> e.g. ∆0xFF0000 (sorry it couldn't be #!)
prefix operator ∆ {}
prefix func ∆(hex: UInt) -> UIColor {
    return UIColor(hex: hex)
}