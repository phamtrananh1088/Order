//
//  GroupView.swift
//  Order
//
//  Created by anh on 2024/11/23.
//

import SwiftUI

struct GroupView<Content: View>: View {
    @ViewBuilder var content: () -> Content
    
    var body: some View {
        VStack(spacing: 0) {
            Divider()
            content()
            Divider()
        }
        .background(.white)
        .frame(maxWidth: .infinity)
    }
}
