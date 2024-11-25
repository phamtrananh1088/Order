//
//  LinkChevronTextView.swift
//  Order
//
//  Created by anh on 2024/11/23.
//

import SwiftUI

struct LinkChevronTextView<Label: View>: View {
    var action: () -> Void
    @ViewBuilder var label: () -> Label
    var body: some View {
        LinkDataChevronTextView(action: action, label: label, data: {EmptyView()})
    }
}

struct LinkDataChevronTextView<Label: View, Data: View>: View {
    var action: () -> Void
    @ViewBuilder var label: () -> Label
    @ViewBuilder var data: () -> Data
    var body: some View {
        Button(action: action, label: {
            HStack {
                label()
                    .padding(.leading, 8)
                Spacer()
                data()
                Image(systemName: "chevron.right")
                    .padding(.trailing, 8)
            }
            
        })
        .buttonStyle(CustomButtonStyle())
        .frame(maxWidth: .infinity)
        .frame(height: 40)
    }
}

private struct CustomButtonStyle: ButtonStyle {
    @State private var isPressed = false
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(height: 40)
            .background(isPressed ? Color.gray.opacity(0.2) : Color.white)
            .foregroundStyle(.black)
            .onChange(of: configuration.isPressed) { newValue in
                isPressed = newValue
            }
    }
}

