//
//  HeadButton.swift
//  Order
//
//  Created by anh on 2024/11/22.
//

import SwiftUI

struct HeadButtonView: View {
    var text: LocalizedStringKey
    var action: () -> Void

    var body: some View {
        Button(action: action, label: {
            Text(text)
                .foregroundStyle(.cyan)
                .font(.system(.subheadline))
                .padding(EdgeInsets(top: 12, leading: 32, bottom: 12, trailing: 32))
                .background(Color.white)
                .clipShape(Capsule())
        })
    }
}

struct HeadButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundStyle(.cyan)
            .font(.system(.subheadline))
            .padding(EdgeInsets(top: 12, leading: 32, bottom: 12, trailing: 32))
            .background(Color.white)
            .clipShape(Capsule())
    }
}
