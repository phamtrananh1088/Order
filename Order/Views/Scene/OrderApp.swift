//
//  OrderApp.swift
//  Order
//
//  Created by anh on 2024/11/05.
//

import SwiftUI

@main
struct OrderApp: App {
    @State private var isShowSplashScreen: Bool = true
    var body: some Scene {
        WindowGroup {
            ZStack {
                ContentView(isShowSplashScreen: $isShowSplashScreen)
                if isShowSplashScreen {
                    SplashView()
                }
            }
        }
    }
}
