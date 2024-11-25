//
//  NoticeRepository.swift
//  Order
//
//  Created by anh on 2024/11/20.
//

import Foundation
import Combine

class NoticeRepository {
    let syncApi: OfflineSyncApi
    var noticeDao : NoticeDao {
        return user.userDB.noticeDao
    }
    var user: LoggedUser {
        Current.shared.user!
    }
    init() {
        syncApi = OfflineSyncApi()
    }
    
    let clientInfo = Config.clientInfo
    let resultDb = Current.shared.resultDB
    var commonNoticeDao: CommonNoticeDao {
        return resultDb.commonNoticeDao
    }
    private var cancellables = Set<AnyCancellable>()
    
    func commitNoticeToCommon() {
        noticeDao.execute(action: { db in
            let pending = try noticeDao.setThenGetPending(db)
            for var notice in pending {
                notice.setSyncFinished()
            }
            let target = pending.map { notice in
                CommonNotice(companyCd: user.userInfo.companyCd, userId: user.userInfo.userId, recordId: notice.recordId, grpRecordId: notice.grdRecordId, sync: notice.sync)
            }
            commonNoticeDao.insertOrReplace(entity: target)
            try noticeDao.updateOrIgnore(db, entity: pending)
            return
        })
    }
    func v(){}
    func send() -> AnyPublisher<Void, NetworkError> {
        commitNoticeToCommon()
        let pending = commonNoticeDao.setThenGetPending()
        if pending.isEmpty {
            return Just(v()).setFailureType(to: NetworkError.self).eraseToAnyPublisher()
        } else {
            let b = NoticePost(notices: pending, clientInfo: clientInfo)
            return syncApi.postNotice(data: b)
                .map { _ in
                    self.commonNoticeDao.delete(entity: pending)
                }
                .eraseToAnyPublisher()
        }
    }
    
    func fetch(_ userInfo: UserInfo) -> AnyPublisher<Void, NetworkError> {
        return syncApi.noticeData(userInfo: userInfo)
            .map { data in
                self.commitNoticeToCommon()
                self.noticeDao.execute { db in
                    try self.noticeDao.deleteAll(db)
                    try self.noticeDao.insertOrReplace(db, entity: data)
                    return
                }
                return
            }
            .eraseToAnyPublisher()
    }
    
    func unreadBy(rank: Int) -> Future<[Notice], Error> {
        noticeDao.unreadByRankFuture(rank: rank)
    }
    
    func allByRank(rank: Int) -> Future<[Notice], Error> {
        return noticeDao.selectByRankFuture(rank: rank)
    }
    
    func markRead(rank: Int) {
        noticeDao.markAllReadByRank(rank: rank, readDate: System.currentTimeMillis())
    }
}
