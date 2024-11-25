//
//  LanguageView.swift
//  Order
//
//  Created by anh on 2024/11/23.
//

import SwiftUI

struct LanguageView: View {
    @EnvironmentObject var contentModel: ContentViewModel
    @EnvironmentObject var model: GeneralSettingViewModel
    @ObservedObject var languageVm: LanguageViewModel
    @State private var isPresentedLanguageSheet: Bool = false
    private var languageChooseVm: LanguageChooseViewModel
    
    init(languageVm: LanguageViewModel) {
        self.languageVm = languageVm
        languageChooseVm = LanguageChooseViewModel()
    }
    var body: some View {
        VStack {
            TopBarView {
                NavigateBackView(title: "setting", label: {
                    Text("language")
                }, onBack: {
                    withAnimation {
                        model.screenName = .generalSettingView
                    }
                })
            }
            GroupView {
                LinkDataChevronTextView(action: {
                    isPresentedLanguageSheet = true
                }, label: {
                    Text("language")
                }, data: {
                    Text(languageChooseVm.getName(key: languageVm.language))
                })
            }
            Spacer()
        }
        .sheet(isPresented: $isPresentedLanguageSheet, content: {
            LanguageChooseView(isPresented: $isPresentedLanguageSheet, currentLanguage: $languageVm.language, languageChooseVm: LanguageChooseViewModel() )
                .environmentObject(contentModel)
        })
    }
}

