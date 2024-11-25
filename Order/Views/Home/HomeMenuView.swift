//
//  HomeMenuView.swift
//  Order
//
//  Created by anh on 2024/11/21.
//

import SwiftUI

struct HomeMenuView: View {
    @EnvironmentObject var contentModel: ContentViewModel
    
    var body: some View {
        Menu(content: {
            Button(action: {
                withAnimation {
                    contentModel.screenName = .settingView
                }
            }, label: {
                HStack {
                    Text("setting")
                    Image(systemName: "gearshape.fill")
                }
            })
            Button(action: {
                withAnimation {
                    contentModel.screenName = .noticeView(NoticeRank.Important_Notice.rawValue)
                }
            }, label: {
                HStack {
                    Text("important notice")
                    Image(systemName: "bell.fill")
                }
            })
            Button(action: {
                withAnimation {
                    contentModel.screenName = .noticeView(NoticeRank.Normal_Notice.rawValue)
                }
            }, label: {
                HStack {
                    Text("normal notice")
                    Image(systemName: "bell")
                }
            })
        }, label: {
            Image(systemName: "ellipsis")
                .font(.system(.title2))
                .foregroundStyle(.white)
                .rotationEffect(Angle(degrees: 90))
        })
    }
}
