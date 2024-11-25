//
//  SnackbarView.swift
//  Order
//
//  Created by anh on 2024/11/15.
//

import Foundation
import SwiftUI

struct SnackbarView: View {
    @Binding var isPresented: Bool
    var message: String
    
    var body: some View {
        VStack {
            Spacer()
            if isPresented {
                Text(LocalizedStringKey(message))
                    .padding()
                    .background(Color.black.opacity(0.8))
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .padding()
                    .transition(.move(edge: .bottom))
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            withAnimation {
                                isPresented = false
                            }
                        }
                    }
            }
        }
    }
}
