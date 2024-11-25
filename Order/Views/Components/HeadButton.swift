//
//  HeadButton.swift
//  Order
//
//  Created by anh on 2024/11/22.
//

import SwiftUI

struct HeadButtonView: View {
    var text: String
    var action: () -> Void

    var body: some View {
        Button(action: action, label: {
            Text(LocalizedStringKey(text))
                .foregroundStyle(.cyan)
                .font(.system(.subheadline))
                .padding(EdgeInsets(top: 12, leading: 32, bottom: 12, trailing: 32))
                .background(Color.white)
                .clipShape(Capsule())
        })
    }
}
