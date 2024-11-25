//
//  CommonDao.swift
//  Order
//
//  Created by anh on 2024/11/20.
//

import Foundation
import GRDB
import EnjoyMacro
import Combine

class CommonDao<T: Recordable>: CommonDataAccessible {
    var dbQueue: DatabaseQueue
    init(dbQueue: DatabaseQueue) {
        self.dbQueue = dbQueue
    }

    func execute(action: (GRDB.Database) throws -> Void) -> Void {
        do {
            try dbQueue.write { db in
                try action(db)
            }
        } catch {
            print(error)
        }
    }

    func execute(action: (GRDB.Database) throws -> [T]) -> [T] {
        do {
            return try dbQueue.write { db in
            try action(db)
            }
        } catch {
            print(error)
            return []
        }
    }
    
    func execute(sql: String) {
        do {
            try dbQueue.write { db in
                try db.execute(sql: sql)
            }
        } catch {
            print(error)
        }
    }
    
    func execute(sql: String, arguments: StatementArguments = StatementArguments()) {
        do {
            try dbQueue.write { db in
                try db.execute(sql: sql, arguments: arguments)
            }
        } catch {
            print(error)
        }
    }
    
    func read(sql: String) -> [Entity] {
        do {
            return try dbQueue.read { db in
                try Entity.fetchAll(db, sql: sql)
            }
        } catch {
            print(error)
            return []
        }
    }
    
    func read(sql: String, arguments: StatementArguments = StatementArguments()) -> [Entity] {
        do {
            return try dbQueue.read { db in
                try Entity.fetchAll(db, sql: sql, arguments: arguments)
            }
        } catch {
            print(error)
            return []
        }
    }
    
    func insert(entity: T) {
        do {
            try dbQueue.write { db in
                try entity.insert(db)
            }
        } catch {
            print(error)
        }
    }
    
    func insert(entity: [T]) {
        do {
            try dbQueue.write { db in
                for e in entity {
                    try e.insert(db)
                }
            }
        } catch {
            print(error)
        }
    }
    
    func insertOrReplace(entity: T) {
        do {
            try dbQueue.write { db in
                try entity.save(db)
            }
        } catch {
            print(error)
        }
    }
    
    func insertOrReplace(entity: [T]) {
        do {
            try dbQueue.write { db in
                for e in entity {
                    try e.save(db)
                }
            }
        } catch {
            print(error)
        }    }
    
    func updateOrIgnore(entity: T) {
        do {
            try dbQueue.write { db in
                try entity.update(db)
            }
        } catch {
            print(error)
        }
    }
    
    func updateOrIgnore(entity: [T]) {
        do {
            try dbQueue.write { db in
                for e in entity {
                    try e.update(db)
                }
            }
        } catch {
            print(error)
        }
    }
    
    func delete(entity: T) -> Bool {
        do {
            return try dbQueue.write { db in
                try entity.delete(db)
            }
        } catch {
            print(error)
            return false
        }
    }
    
    func delete(entity: [T]) {
        do {
             try dbQueue.write { db in
                 for e in entity {
                     try e.delete(db)
                 }
            }
        } catch {
            print(error)
        }
    }
    
    func insert(_ db: GRDB.Database, entity: T) throws {
        try entity.insert(db)
    }
    
    func insert(_ db: GRDB.Database, entity: [T]) throws {
        for e in entity {
            try e.insert(db)
        }
    }
    
    func insertOrReplace(_ db: GRDB.Database, entity: T) throws {
        try entity.save(db)
    }
    
    func insertOrReplace(_ db: GRDB.Database, entity: [T]) throws {
        for e in entity {
            try e.save(db)
        }
    }
    
    func updateOrIgnore(_ db: GRDB.Database, entity: T) throws {
        try entity.update(db)
    }
    
    func updateOrIgnore(_ db: GRDB.Database, entity: [T]) throws {
        for e in entity {
            try e.update(db)
        }
    }
    
    func delete(_ db: GRDB.Database, entity: T) throws -> Bool {
        try entity.delete(db)
    }
    
    func delete(_ db: GRDB.Database, entity: [T]) throws {
        for e in entity {
            try e.delete(db)
        }
    }
    
    typealias Entity = T
    
    
}
