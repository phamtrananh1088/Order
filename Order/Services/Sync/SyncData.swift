//
//  SyncData.swift
//  Order
//
//  Created by anh on 2024/11/11.
//

import Foundation
import GRDB
import Combine

class SyncData {

    func syncNotice(callback: @escaping () -> Void) {
        NoticeTask(callback: callback).execute()
    }
    
    class NoticeTask: TaskRetry {
        var callback: () -> Void
        var loggedUser: LoggedUser?
        var retry: Int
        var cancellables = Set<AnyCancellable>()
        
        init(callback: @escaping () -> Void) {
            retry = Config.env.retry
            loggedUser = Current.shared.user
            self.callback = callback
        }
        
        func execute() {
            if let user = loggedUser {
                let noticeRepo = NoticeRepository()
                noticeRepo.send()
                    .retry(retry)
                    .flatMap { _ in
                        noticeRepo.fetch(user.userInfo)
                    }
                    .receive(on: DispatchQueue.main)
                    .sink(receiveCompletion: { completion in
                        switch completion {
                        case .finished: break
                        case .failure(let error):
                            print(error)
                        }
                        self.callback()
                    }, receiveValue: {})
                    .store(in: &cancellables)
            }
        }
    }
}

protocol TaskRetry {
    var loggedUser: LoggedUser? {get set}
    var retry: Int {get set}

    func execute()
}

