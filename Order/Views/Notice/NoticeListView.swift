//
//  NoticeListView.swift
//  Order
//
//  Created by anh on 2024/11/22.
//

import SwiftUI

struct NoticeListWithConfirm2: View {
    @EnvironmentObject var contentModel: ContentViewModel
    @ObservedObject var noticelistVm: NoticeListViewModel
    var buttonClick: () -> Void
    
    var body: some View {
        VStack {
            ZStack {
                Color.cyan
                NoticeListWithConfirmView(list: $noticelistVm.noticeList, buttonClick: {
                    noticelistVm.noticeMarkRead(rank: NoticeRank.Important_Notice.rawValue)
                    buttonClick()
                }, noticeClick: { notice in
                    switch notice.useCase {
                    case .Logout:
                        Current.shared.logout()
                        withAnimation {
                            contentModel.reset()
                        }
                    case .Restart:
                        Current.shared.restart()
                        withAnimation {
                            contentModel.reset()
                        }
                    case .None:
                        break
                    }
                })
            }
        }
    }
}
private struct NoticeListWithConfirmView: View {
    @Binding var list: ResultAPI<[NoticeModel]>
    var buttonClick: () -> Void
    var noticeClick: (NoticeModel) -> Void
    @State private var showConfirm: Bool = false
    @State private var notice: NoticeModel? = nil
    var body: some View {
        NoticeListView(list: $list, buttonClick: buttonClick, noticeClick: { n in
            showConfirm = true
            notice = n
        })
        .alert("notice_send_data_alert_title", isPresented: $showConfirm, actions: {
            Button("yes") {
                noticeClick(notice!)
            }
            Button(role: .cancel, action: {
                
            }, label: {
                Text("cancel")
            })
        }, message: {
            Text("notice_send_data_alert_ms")
        })
    }
}
private struct NoticeListView: View {
    @Binding var list: ResultAPI<[NoticeModel]>
    var buttonClick: () -> Void
    var noticeClick: (NoticeModel) -> Void
    var body: some View {
        ZStack {
            Color.cyan
            if case .Loading = list {
                LightingProgressView()
            } else if let list = list.getOrNull() {
                if list.isEmpty {
                    ZStack {
                        Text("no_data_placeholder")
                            .font(.body)
                            .foregroundStyle(.white)
                        VStack() {
                            Spacer()
                            Footer(action: buttonClick)
                            Spacer().frame(height: 80)
                        }
                    }
                } else {
                    VStack {
                        ScrollView {
                            VStack {
                                Spacer()
                                    .frame(height: 90)
                                VStack(spacing: 6) {
                                    ForEach(list) { notice in
                                        CardView {
                                            NoticeItem(notice: notice)
                                        }
                                        .onTapGesture {
                                            if notice.useCase.clickable() {
                                                withAnimation {
                                                    noticeClick(notice)
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        Spacer()
                        Footer(action: buttonClick)
                        Spacer().frame(height: 80)
                    }
                }
            }
        }
    }
}

private struct Footer: View {
    var action: () -> Void
    var body: some View {
        Button(action: action, label: {
            Text("notice_mark_read")
                .modifier(HeadButtonModifier())
        })
    }
}

private struct NoticeItem: View {
    var notice: NoticeModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(notice.title)
                    .fontWeight(.semibold)
                    .foregroundStyle(.noticeTitle)
                if notice.isNew {
                    Text(String(stringLiteral: "NEW"))
                        .foregroundStyle(.red)
                }
            }
            .font(.headline)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Text(notice.content)
                .font(.body)
        }
        .frame(maxWidth: .infinity)
    }
}
