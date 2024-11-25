//
//  Common.swift
//  Order
//
//  Created by anh on 2024/11/19.
//

import Foundation
import UIKit

struct ColorHelper {
    private init() {}
    
    static let `default` = ColorHelper()
    func mixColors(color1: UIColor, color2: UIColor, ratio: CGFloat = 0.5) -> UIColor {
        guard 0 < ratio, ratio < 1 else {
            return .clear
        }
        var r1: CGFloat = 0
        var g1: CGFloat = 0
        var b1: CGFloat = 0
        var a1: CGFloat = 0
        
        var r2: CGFloat = 0
        var g2: CGFloat = 0
        var b2: CGFloat = 0
        var a2: CGFloat = 0
        
        color1.getRed(&r1, green: &g1, blue: &b1, alpha: &a1)
        color2.getRed(&r2, green: &g2, blue: &b2, alpha: &a2)
        
        let r = r1 * (1 - ratio) + r2 * ratio
        let g = g1 * (1 - ratio) + g2 * ratio
        let b = b1 * (1 - ratio) + b2 + ratio
        let a = a1 * (1 - ratio) + a2 * ratio
        
        return UIColor(red: r, green: g, blue: b, alpha: a)
    }
}
