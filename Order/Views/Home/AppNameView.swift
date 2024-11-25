//
//  AppNameView.swift
//  Order
//
//  Created by anh on 2024/11/21.
//

import SwiftUI

struct AppNameView: View {
    var body: some View {
        Text("app name")
            .font(.system(.title))
            .fontWeight(.bold)
            .foregroundStyle(.white)
            .padding(.horizontal)
        Spacer()
        Text(System.currentDateDayInWeek())
            .font(.system(.body))
    }
}
