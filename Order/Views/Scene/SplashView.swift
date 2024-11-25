//
//  SplashView.swift
//  Order
//
//  Created by anh on 2024/11/11.
//

import Foundation
import SwiftUI

struct SplashView: View {
    private let width: CGFloat = 120
    var body: some View {
        ZStack {
            Color.cyan
            VStack {
                Spacer()
                ZStack {
                    Color.white
                        .clipShape(Circle())
                        .frame(width: width, height: width)
                    Color.cyan
                        .clipShape(RoundedRectangle(cornerRadius: 4))
                        .frame(width: width * cos(Angle(degrees: 45).radians) - 8, height: width * cos(Angle(degrees: 45).radians) - 8)
                    Text("app name")
                        .foregroundColor(.white)
                        .font(.system(.title2))
                }
            
                Spacer()
                    
            }
        }
        .ignoresSafeArea()
    }
}
