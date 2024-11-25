//
//  CommonNoticeDao.swift
//  Order
//
//  Created by anh on 2024/11/20.
//

import Foundation

class CommonNoticeDao: CommonDao<CommonNotice>, CommonSyncDataAccessible {
    var setPendingSql: String = "update commonNotice set sync = \(SyncStatus.pending.rawValue) where sync = \(SyncStatus.changed.rawValue)"
    
    var getPendingSql: String = "select * from commonNotice where sync = \(SyncStatus.pending.rawValue)"
    
    var deleteSyncedSql: String = "delete from commonNotice where sync = \(SyncStatus.done.rawValue)"
}
