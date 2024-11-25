//
//  TopBarView.swift
//  Order
//
//  Created by anh on 2024/11/23.
//

import SwiftUI

struct TopBarView<Content: View>: View {
    @ViewBuilder var content: () -> Content
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color.cyan.frame(height: 90)
            
            HStack {
                content()
            }
            .padding(6)
        }
    }
}
