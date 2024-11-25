//
//  CommonSynDao.swift
//  Order
//
//  Created by anh on 2024/11/20.
//

import Foundation
import GRDB

protocol CommonSyncDataAccessible: CommonDataAccessible {
    func setPending()
    func getPending() -> [Entity]
    func deleteSynced()
    func setThenGetPending(_ db: Database) throws -> [Entity]
    var setPendingSql: String {get}
    var getPendingSql: String {get}
    var deleteSyncedSql: String {get}
}

extension CommonSyncDataAccessible {
    func setPending() {
        execute(sql: setPendingSql)
    }
    
    func getPending() -> [Entity] {
        return read(sql: getPendingSql)
    }

    func deleteSynced() {
        execute(sql: deleteSyncedSql)
    }
    
    func setThenGetPending(_ db: GRDB.Database) throws -> [Entity] {
        try db.execute(sql: setPendingSql)
        return try Entity.fetchAll(db, sql: getPendingSql)
    }
    
    func setThenGetPending() -> [Entity] {
       return execute(action: { db in
        try setThenGetPending(db)
        })
    }
}
