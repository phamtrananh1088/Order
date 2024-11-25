//
//  LanguageViewModel.swift
//  Order
//
//  Created by anh on 2024/11/23.
//

import Foundation

class LanguageViewModel: ObservableObject {
    @Published var language: String
    
    init() {
        language = Config.pref.language ?? ""
    }
}
