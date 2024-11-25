//
//  OrderGRDB.swift
//  Order
//
//  Created by anh on 2024/11/06.
//

import Foundation
import GRDB

class OrderGRDB {
    let databasePath: String
    lazy var db: DatabaseQueue = {
        return makeDb()
    }()
    init(databasePath: String) {
        self.databasePath = databasePath
    }
    func exist() -> Bool {
        return FileManager.default.fileExists(atPath: databasePath)
    }
    func makeDb() -> DatabaseQueue {
        if !exist() {
            FileManager.default.createFile(atPath: databasePath, contents: nil)
        }
        guard let _db = try? DatabaseQueue(path: databasePath) else {
            fatalError("couldn't make database")
        }
        return _db
    }
    func createTable(_ table: TableSchema.Type) throws {
        try db.write{ ctx in
            try ctx.execute(sql: table.createTable())
        }
    }
    func dropDb() throws {
        try FileManager.default.removeItem(atPath: databasePath)
    }
}
