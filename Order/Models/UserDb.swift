//
//  UserDb.swift
//  Order
//
//  Created by anh on 2024/11/06.
//

import Foundation
import GRDB
import EnjoyMacro

class UserDb: OrderGRDB {
    lazy var noticeDao: NoticeDao = {
        NoticeDao(dbQueue: db)
    }()
    
    func createAllTable() throws {
        try createTable(BinHeader.self)
        try createTable(BinDetail.self)
        try createTable(Notice.self)
    }
}
