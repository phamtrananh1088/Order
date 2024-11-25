//
//  LanguageChooseViewModel.swift
//  Order
//
//  Created by anh on 2024/11/23.
//

import Foundation

class LanguageChooseViewModel: ObservableObject {
    var listLanguage: [LanguageModel] = []
    
    init() {
        listLanguage = [
        LanguageModel(key: "ja-JP", name: "日本語", localizedName: "japan"),
        LanguageModel(key: "en-US", name: "English", localizedName: "english")
        ]
    }
    
    func getName(key: String) -> String {
        listLanguage.first(where: {$0.key == key})?.name ?? ""
    }
}
