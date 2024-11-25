//
//  DefaultBottomSheet.swift
//  Order
//
//  Created by anh on 2024/11/25.
//

import SwiftUI

struct DefaultBottomSheet<Content: View>: View {
    @Binding var isPresented: Bool
    @ViewBuilder var content: () -> Content
    @State private var alpha: CGFloat = 0
   
    var body: some View {
        ZStack {
            Color(UIColor(white: 0.1, alpha: isPresented ? alpha : 0))
                .onTapGesture {
                    withAnimation {
                        isPresented = false
                    }
                }
            
            VStack {
                Spacer()
                
                content()
                .padding()
                .background(Color.white)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6, execute: {
                alpha = 0.1
            })
        }
    }
}
