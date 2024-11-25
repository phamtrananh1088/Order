//
//  ResultDb.swift
//  Order
//
//  Created by anh on 2024/11/07.
//

import Foundation
import GRDB
import EnjoyMacro

class ResultDb: OrderGRDB {
    lazy var commonNoticeDao: CommonNoticeDao = {
        CommonNoticeDao(dbQueue: db)
    }()
    lazy var buildVersionDao: BuildVersionDao = {
       BuildVersionDao(dbQueue: db)
    }()

    func createAllTable() throws {
        try createTable(CommonBinResult.self)
        try createTable(CommonNotice.self)
        try createTable(BuildVersion.self)
    }
}
