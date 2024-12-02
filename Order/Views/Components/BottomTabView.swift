//
//  BottomTabView.swift
//  Order
//
//  Created by anh on 2024/12/01.
//

import SwiftUI

enum HomeTab: Int {
   case Dashboard = 1
    case Delivery = 2
    case WorkItem = 3
    case FuelCharge = 4
    case ChatRoom = 5
}
struct BottomTabView: View {
    @State var selectedTab: Int = HomeTab.Dashboard.rawValue
    var body: some View {
        TabView(selection: $selectedTab, content: {
            Text("Dashboard")
                .tabItem({
                    Label("Dashboard", systemImage: "")
                })
            
        })
    }
}

#Preview {
    BottomTabView()
}
