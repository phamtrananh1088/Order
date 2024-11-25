//
//  ColorPaleteView.swift
//  Order
//
//  Created by anh on 2024/11/19.
//

import Foundation
import SwiftUI

private struct CustomColor: Identifiable {
    var name: String
    var uiColor: UIColor
    var id: String {name}
}
struct ColorPaleteView: View {
    @State private var r: CGFloat = 0
    @State private var g: CGFloat = 0
    @State private var b: CGFloat = 0
    @State private var a: CGFloat = 1
    @State private var customColors: [CustomColor] = []
    var body: some View {
        VStack {
            VStack {
                Text("Custom Color")
                    .font(.system(.headline))
                ForEach(customColors) { c in
                    HStack {
                        Text(c.name)
                            .foregroundStyle(Color(uiColor: c.uiColor))
                            .frame(width: 100)
                        Circle()
                            .foregroundStyle(Color(uiColor: c.uiColor))
                            .frame(width: 30, height: 30)
                    }
                }
            }
            .padding(.bottom, 40)
            Stepper {
                Text("red \(Int(r)), hex: \(String(format: "%02x", Int(r)))")
                Slider(value: $r, in: 0...255, step: 1)
            }
        onIncrement: {
            r = r + 1
        } onDecrement: {
            r = r - 1
        }
            
            Stepper {
                Text("green \(Int(g)), hex: \(String(format: "%02x", Int(g)))")
                Slider(value: $g, in: 0...255, step: 1)
            }
        onIncrement: {
            g = g + 1
        } onDecrement: {
            g = g - 1
        }
            
            Stepper {
                Text("blue \(Int(b)), hex: \(String(format: "%02x", Int(b)))")
                Slider(value: $b, in: 0...255, step: 1)
            }
        onIncrement: {
            b = b + 1
        } onDecrement: {
            b = b - 1
        }
            Color(uiColor: UIColor(red: r / 255, green: g / 255, blue: b / 255, alpha: a))
                .clipShape(Circle())
                .frame(width: 60, height: 60)
            Text("Hello, world!")
                .font(.system(.caption))
                .foregroundStyle(Color(uiColor: UIColor(red: r / 255, green: g / 255, blue: b / 255, alpha: a)))
            Button(action: {
                let customColor = CustomColor(name: "\(String(format: "%02x", Int(r)))\(String(format: "%02x", Int(g)))\(String(format: "%02x", Int(b)))", uiColor: UIColor(red: r / 255, green: g / 255, blue: b / 255, alpha: a))
                if customColors.first(where: {
                    return $0.name == customColor.name
                }) == nil {
                    customColors.append(customColor)
                }
            }, label: {
                Text("add to custom")
                    .padding()
                    .frame(width: 160, height: 40)
                    .background(Color.cyan)
                    .clipShape(Capsule())
            })
        }
        .padding()
    }
    
    
}


