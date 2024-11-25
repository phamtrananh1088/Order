//
//  NoticeDao.swift
//  Order
//
//  Created by anh on 2024/11/20.
//

import Foundation
import GRDB
import Combine
import EnjoyMacro

class NoticeDao: CommonDao<Notice>, CommonSyncDataAccessible {
    var setPendingSql: String = "update notice set sync = \(SyncStatus.pending.rawValue) where sync = \(SyncStatus.changed.rawValue) and unreadFlag = 0"
    
    var getPendingSql: String = "select * from notice where sync = \(SyncStatus.pending.rawValue)"
    
    var deleteSyncedSql: String = "delete from notice where sync = \(SyncStatus.done.rawValue)"
    
    func deleteAll() {
        execute(action: deleteAll)
    }

    func deleteAll(_ db: Database) throws {
        try db.execute(sql: "delete from notice")
    }
    
    @combineFuture 
    func unreadByRank(rank: Int) -> [Notice] {
        read(sql: "select * from notice where eventRank = :rank and unreadFlag = 1 order by publicationDateFrom desc", arguments: ["rank": rank])
    }
    
    @combineFuture 
    func selectByRank(rank: Int) -> [Notice] {
        read(sql: "select * from notice where eventRank = :rank order by publicationDateFrom desc", arguments: ["rank": rank])
    }
    
   
    func markAllReadByRank(rank: Int, readDate: Int64) {
        execute(sql: """
update notice
set unreadFlag = 0, readDatetime = :readDate, sync = \(SyncStatus.changed.rawValue)
where eventRank = :rank and unreadFlag = 1
""", arguments: ["rank": rank, "readDate": readDate ])
    }
}
