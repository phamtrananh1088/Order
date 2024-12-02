//
//  ContentView.swift
//  Order
//
//  Created by anh on 2024/11/05.
//

import SwiftUI
import EnjoyMacro

struct ContentView: View {
//    @ObservedObject var current: Current = Current.shared
//    @StateObject private var contentModel: ContentViewModel = ContentViewModel()
    @EnvironmentObject var contentModel: ContentViewModel
    @Binding var isShowSplashScreen: Bool
    init(isShowSplashScreen: Binding<Bool>) {
        self._isShowSplashScreen = isShowSplashScreen
    }
    
    var body: some View {
        VStack {
            if case .loginView = contentModel.screenName {
                //                    ColorPaleteView()
                //                        .background(Color.white)
                LoginPhaseView()
                    .environmentObject(contentModel)
            } else if case .homeView = contentModel.screenName {
                HomeView()
                    .environmentObject(contentModel)
            } else if case .noticeView(let rank) = contentModel.screenName {
                NoticeListWithConfirm2(noticelistVm: NoticeListViewModel(rank: rank), buttonClick: {
                    contentModel.screenName = .homeView
                })
                .environmentObject(contentModel)
                .transition(.move(edge: .trailing))
            }  else if case .settingView = contentModel.screenName {
                GeneralSettingView()
                    .environmentObject(contentModel)
                    .transition(.move(edge: .trailing))
            }else {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text("Hello, world!")
                Button(action: {
                    print(#stringify("x + y"))
                    print(#dateBuilded())
                    
                }, label: {
                    Text("stringify macro")
                })
                Spacer()
                    .task {
                        start()
                    }
            }
        }
        .ignoresSafeArea()
        .alert("", isPresented: $contentModel.isLogouted, actions: {
            Button("ok", action: {
                Current.shared.logout()
                withAnimation {
                    contentModel.reset()
                }
            })
        }, message: {
            Text("invalid_account_alert_msg")
        })
    }
    
    private func start() -> Void {
        isShowSplashScreen = true
        BuildVersionRepository().initDatabase()
        let user = user()
        if user == nil {
            withAnimation {
                contentModel.screenName = .loginView
            }
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                withAnimation {
                    isShowSplashScreen = false
                }
            }
        } else {
            withAnimation {
                contentModel.screenName = .homeView
            }
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                withAnimation {
                    isShowSplashScreen = false
                }
            }
        }
    }
    
    private func user() -> LoggedUser? {
        let u = Current.shared.user
        if let u = u {
            return u
        } else {
            Current.shared.tryLoginFromSavedInfo()
            return Current.shared.user
        }
    }
}

//#Preview {
//    ContentView()
//}
