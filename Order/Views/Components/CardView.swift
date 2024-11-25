//
//  CardView.swift
//  Order
//
//  Created by anh on 2024/11/22.
//

import SwiftUI

struct CardView<Content: View>: View {
    var color: Color = .white
    var border: Color? = nil
    @ViewBuilder var content: () -> Content
    
    var body: some View {
        VStack() {
            content()
                .padding(6)
        }
        .background(color)
        .applyIf(border != nil) {
            $0.border(border!)
        }
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .padding(.horizontal, 8)
    }
}
