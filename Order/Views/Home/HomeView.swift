//
//  HomeView.swift
//  Order
//
//  Created by anh on 2024/11/21.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var contentModel: ContentViewModel
    var body: some View {
        VStack {
            TopBarView {
            
                    AppNameView()
                    HomeMenuView()
                        .environmentObject(contentModel)
               
            }
            
            Spacer()
        }
    }
}


