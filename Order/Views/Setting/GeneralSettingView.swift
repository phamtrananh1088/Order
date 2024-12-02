//
//  GeneralSettingView.swift
//  Order
//
//  Created by anh on 2024/11/23.
//

import SwiftUI

struct GeneralSettingView: View {
    @EnvironmentObject var contentModel: ContentViewModel
    @StateObject private var model: GeneralSettingViewModel = GeneralSettingViewModel()
    private var contactNumber: String = "044-738-0011"
    var body: some View {
        VStack {
            if case .generalSettingView = model.screenName {
                TopBarView {
                    NavigateBackView(title: "home", label: {
                        Text("setting")
                    }, onBack: {
                        withAnimation {
                            contentModel.screenName = .homeView
                        }
                    })
                }
                ScrollView {
                    VStack {
                       
                            Spacer()
                                .frame(height: 60)
                            Text("ask_for_support")
                            Button(action: {
                                if let url = URL(string: "tel://\(contactNumber.replacingOccurrences(of: "-", with: ""))"), UIApplication.shared.canOpenURL(url) {
                                    UIApplication.shared.open(url)
                                } else {
                                    print("Your device cannot make phone calls.")
                                }
                            }, label: {
                                HStack {
                                    Image(systemName: "phone")
                                    Text(contactNumber)
                                }
                                .foregroundColor(.white)
                                .frame(width: 200, height: 40)
                                .background(Color.cyan)
                                .clipShape(Capsule())
                            })
                        Spacer()
                            .frame(height: 60)
                        GroupView {
                            Spacer()
                                .frame(height: 30)
                            Button(action: {
                                withAnimation {
                                    model.screenName = .weatherView
                                }
                            }, label: {
                                HStack {
                                    Text("weather_setting")
                                }
                                .foregroundColor(.white)
                                .frame(width: 200, height: 40)
                                .background(Color.cyan)
                                .clipShape(Capsule())
                            })
                            Spacer()
                                .frame(height: 30)
                        }
                        Spacer()
                            .frame(height: 30)
                            Button(action: {
                                Current.shared.logout()
                                withAnimation {
                                    contentModel.screenName = .loginView
                                }
                            }, label: {
                                HStack {
                                    Text("switch_user")
                                }
                                .foregroundColor(.white)
                                .frame(width: 200, height: 40)
                                .background(Color.cyan)
                                .clipShape(Capsule())
                            })
                        Spacer()
                            .frame(height: 30)
                        
                        GroupView {
                            LinkChevronTextView(action: {
                                withAnimation {
                                    model.screenName = .languageView
                                }
                            }, label: {
                                Text("language")
                            })
                        }
                        Text("terminal id \(Config.clientInfo.terminalId)")
                            .frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                    }
                }
            } else if case .weatherView = model.screenName {
                WeatherView(weatherVm: WeatherViewModel(), buttonText: "weather_setup_close", buttonClick: {
                    withAnimation {
                        model.screenName = .generalSettingView
                    }
                })
                .transition(.move(edge: .trailing))
            } else if case .languageView = model.screenName {
                LanguageView(languageVm: LanguageViewModel())
                    .environmentObject(model)
//                    .environmentObject(contentModel)
                    .transition(.move(edge: .trailing))
            }
        }
        .frame(maxHeight: .infinity)
    }
}

