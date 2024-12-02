//
//  LoginPhaseView.swift
//  Order
//
//  Created by anh on 2024/11/19.
//

import SwiftUI

struct LoginPhaseView: View {
    @EnvironmentObject var contentModel: ContentViewModel
    @State private var loggedInState: Int = 0
    @State private var loadNotice: Bool = false
    @ObservedObject var noticelistVm: NoticeListViewModel = NoticeListViewModel()
    var body: some View {
        if 2 == loggedInState {
            WeatherView(weatherVm: WeatherViewModel(), buttonText: "go_to_home_dashboard", buttonClick: {
                withAnimation {
                    contentModel.screenName = .homeView
                }
            })
            .transition(.move(edge: .leading))
        } else if 1 == loggedInState {
            if case .Loading = noticelistVm.noticeList {
                ZStack {
                    Color.cyan
                    LightingProgressView()
                }
            } else {
                if let n = noticelistVm.noticeList.getOrNull() {
                    if n.isEmpty {
                        WeatherView(weatherVm: WeatherViewModel(), buttonText: "go_to_home_dashboard", buttonClick: {
                            withAnimation {
                                contentModel.screenName = .homeView
                            }
                        })
                        .transition(.move(edge: .leading))
                    } else {
                        NoticeListWithConfirm2(noticelistVm: noticelistVm, buttonClick: {
                            DispatchQueue.main.async {
                                loggedInState = 2
                            }
                        })
                        .transition(.move(edge: .leading))
                    }
                }
            }
        } else {
            LoginView(loginVm: LoginViewModel(defaultCompantCd: Config.pref.lastUserCompany ?? "")) { u in
                Current.shared.login(login: u.user, json: u.json)
                SyncData().syncNotice(callback: {
                    DispatchQueue.main.async(execute: {
                        withAnimation {
                            loggedInState = 1
                        }
                        noticelistVm.noticeList(rank: NoticeRank.Important_Notice.rawValue, unreadOnly: true)
                    })
                })
            }
        }
    }
}

