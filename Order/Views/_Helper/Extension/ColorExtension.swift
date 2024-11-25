//
//  ColorExtension.swift
//  Order
//
//  Created by anh on 2024/11/19.
//

import Foundation
import SwiftUI

extension Color {
    static var error: Color = Color(uiColor: UIColor(red: 218, green: 70, blue: 0))
    static var noticeTitle: Color = Color(uiColor: UIColor(rgb: 0xffee8833))
}

extension UIColor {
    convenience init(red: Int,green: Int,blue: Int) {
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}
extension ShapeStyle where Self == Color {
    
    static var error: Color { .error }
    static var noticeTitle: Color { .noticeTitle }
}
