//
//  HomeView.swift
//  Order
//
//  Created by anh on 2024/11/21.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var contentModel: ContentViewModel
    @State private var text: String = ""
    @ObservedObject private var keyboardResponder = KeyboardResponder()
    var body: some View {
        VStack {
            TopBarView {
            
                    AppNameView()
                    HomeMenuView()
                        .environmentObject(contentModel)
               
            }
            
//            Button(action: {
//                Task {
//                    await NotificationService.shared.scheduleMeetingLocalNotification()
//                }
//            }, label: {Text("test local notification").modifier(HeadButtonModifier())})
//            Button( action: {
//                NotificationCenter.default.post(name: Notification.Name(NotificationName.loggedOut.rawValue), object: nil)
//            }, label: {Text("test logged out").modifier(HeadButtonModifier())})
//            
//            TextField("test keyboard show/hide", text: $text)
//            if keyboardResponder.isShow {
//                Text("keyboard show with height \(keyboardResponder.keyboardSize?.height ?? 0)")
//            } else {
//                Text("keyboard hide")
//            }
//            
//            Spacer()
            BottomTabView()
        }
        .task {
            _ = await NotificationService.shared.requestAuthorization()
        }
    }
}


