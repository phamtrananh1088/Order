//
//  NoticeListViewModel.swift
//  Order
//
//  Created by anh on 2024/11/20.
//

import Foundation
import Combine

class NoticeListViewModel: ObservableObject {
    let noticeRepo: NoticeRepository
    private var cancelables = Set<AnyCancellable>()
    @Published var noticeList: ResultAPI<[NoticeModel]> = .Loading
    
    init() {
        noticeRepo = NoticeRepository()
    }
    convenience init(rank: Int) {
        self.init()
        noticeList(rank: rank, unreadOnly: false)
    }
    
    func noticeList(rank: Int, unreadOnly: Bool) {
        let ob = unreadOnly ? noticeRepo.unreadBy(rank: rank) : noticeRepo.allByRank(rank: rank)
        ob.map { a in
            a.map { n in
                let c = n.noticeText ?? ""
                return NoticeModel(id: n.recordId, title: n.noticeTitle ?? "", content: c, isNew: n.unreadFlag && !c.isEmpty, useCase: n.useCase)
            }
        }
        .receive(on: DispatchQueue.main)
        .sink(receiveCompletion: {_ in}, receiveValue: {data in
            self.noticeList = ResultAPI.Value(data)
        })
        .store(in: &cancelables)
    }
    
    func noticeMarkRead(rank: Int) {
        Task {
            noticeRepo.markRead(rank: rank)
            SyncData().syncNotice {/*noCallBack*/}
        }
    }
    
}
