//
//  ButtonStyle.swift
//  Order
//
//  Created by anh on 2024/11/25.
//

import Foundation
import SwiftUI

struct ClearButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background(Color.clear)
            .foregroundStyle(.white)
    }
}
