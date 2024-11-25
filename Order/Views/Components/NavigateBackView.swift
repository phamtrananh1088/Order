//
//  NavigateBackView.swift
//  Order
//
//  Created by anh on 2024/11/23.
//

import SwiftUI

struct NavigateBackView<Label: View>: View {
    var title: LocalizedStringKey = ""
    @ViewBuilder var label: () -> Label
    var onBack: () -> Void
    
    var body: some View {
        ZStack {
            HStack {
                Button(action: onBack, label: {
                    HStack {
                        Image(systemName: "chevron.left")
                            .foregroundStyle(.white)
                        Text(title)
                            .underline()
                            .foregroundStyle(.white)
                    }
                })
                Spacer()
            }
            label()
                .foregroundStyle(.black)
        }
        .font(.title3)
//        .padding(.horizontal)
//        .padding(.vertical, 4)
    }
}

