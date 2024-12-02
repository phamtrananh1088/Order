//
//  LanguageChooseView.swift
//  Order
//
//  Created by anh on 2024/11/23.
//

import SwiftUI

struct LanguageChooseView: View {
    @EnvironmentObject var contentModel: ContentViewModel
    @Binding var isPresented: Bool
    @Binding var currentLanguage: String
    @ObservedObject var languageChooseVm: LanguageChooseViewModel
    @State private var isShowConfirm: Bool = false
    @State private var language: String = ""
    var body: some View {
        ZStack {
            Color.cyan
            ScrollView {
                VStack {
                    Text("language")
                        .font(.title2)
                        .padding()
                    
                    HStack(){
                        Spacer()
                        Button(action: {
                            withAnimation {
                                isPresented = false
                            }
                        }, label: {
                            Text("cancel")
                                .underline()
                                .font(.body)
                                .foregroundStyle(.white)
                        })
                    }
                    .padding()
                    .frame(height: 60)
                    CardView {
                        VStack {
                            ForEach(languageChooseVm.listLanguage.indices, id: \.self) { index in
                                let lang = languageChooseVm.listLanguage[index]
                                Button(action: {
                                    if currentLanguage != lang.key {
                                        isShowConfirm = true
                                        language = lang.key
                                    }
                                }, label: {
                                    HStack {
                                        VStack(alignment: .leading) {
                                            Text(lang.name)
                                            Text(LocalizedStringKey(lang.localizedName))
                                        }
                                        .foregroundStyle(.black)
                                        Spacer()
                                        if currentLanguage == lang.key {
                                            Image(systemName: "checkmark")
                                                .foregroundStyle(.cyan)
                                        }
                                    }
                                })
                                if index < languageChooseVm.listLanguage.count - 1 {
                                    Divider()
                                }
                            }
                            
                        }
                        .padding(.leading, 8)
                        .alert("", isPresented: $isShowConfirm, actions: {
                            Button(action: {
                                Config.pref.setLanguage(languageCode: language)
                                Current.shared.restart()
                                withAnimation {
                                    contentModel.reset()
                                }
                            }, label: {
                                Text("yes")
                            })
                            Button(role: .cancel, action: {}, label: {
                                Text("cancel")
                            })
                        }, message: {
                            Text("change language alert")
                        })
                    }
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

