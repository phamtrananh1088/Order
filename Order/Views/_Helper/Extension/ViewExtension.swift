//
//  ViewExtension.swift
//  Order
//
//  Created by anh on 2024/11/22.
//

import SwiftUI

extension View {
    @ViewBuilder
    @inlinable func applyIf<Content: View> (_ condition: Bool, _ transform: (Self) -> Content ) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
    
    func overlayBottom<Content: View> (isPresented: Binding<Bool>, @ViewBuilder content: () -> Content) -> some View {
        self.overlay(alignment: .bottom, content: {
            if isPresented.wrappedValue {
                content()
                .transition(.move(edge: .bottom))
            } else {
                EmptyView()
            }
        })
    }
}
