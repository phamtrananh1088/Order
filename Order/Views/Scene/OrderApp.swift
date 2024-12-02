//
//  OrderApp.swift
//  Order
//
//  Created by anh on 2024/11/05.
//

import SwiftUI

@main
struct OrderApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @State private var isShowSplashScreen: Bool = true
    @StateObject private var contentModel: ContentViewModel = ContentViewModel()
    var body: some Scene {
        WindowGroup {
            ZStack {
                ContentView(isShowSplashScreen: $isShowSplashScreen)
                    .id(contentModel.id)
                if isShowSplashScreen {
                    SplashView()
                }
            }
            .environmentObject(contentModel)
        }
    }
}
