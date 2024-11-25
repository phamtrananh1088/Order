//
//  CommonDao.swift
//  Order
//
//  Created by anh on 2024/11/20.
//

import Foundation
import GRDB

protocol CommonDataAccessible {
    associatedtype Entity: Recordable
    func insert(entity: Entity)
    func insert(entity: [Entity])
    func insertOrReplace(entity: Entity)
    func insertOrReplace(entity: [Entity])
    func updateOrIgnore(entity: Entity)
    func updateOrIgnore(entity: [Entity])
    func delete(entity: Entity) -> Bool
    func delete(entity: [Entity])
    func insert(_ db: Database, entity: Entity) throws
    func insert(_ db: Database, entity: [Entity]) throws
    func insertOrReplace(_ db: Database, entity: Entity) throws
    func insertOrReplace(_ db: Database, entity: [Entity]) throws
    func updateOrIgnore(_ db: Database, entity: Entity) throws
    func updateOrIgnore(_ db: Database, entity: [Entity]) throws
    func delete(_ db: Database, entity: Entity) throws -> Bool
    func delete(_ db: Database, entity: [Entity]) throws
    func execute(sql: String)
    func execute(sql: String, arguments: StatementArguments)
    func execute(action: (_ db: Database) throws -> Void) -> Void
    func execute(action: (_ db: Database) throws -> [Entity]) -> [Entity]
    func read(sql: String) -> [Entity]
    func read(sql: String, arguments: StatementArguments) -> [Entity]
}
