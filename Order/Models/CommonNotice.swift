//
//  CommonNotice.swift
//  Order
//
//  Created by anh on 2024/11/20.
//

import Foundation
import EnjoyMacro
import GRDB

@createTable("commonNotice", "companyCd, userId, recordId")
struct CommonNotice: Recordable, SyncRecord, TableSchema {
    var companyCd: String
    var userId: String
    var recordId: String
    var grpRecordId: String
    var noticeCd: String?
    var readDatetime: Int64?
    var sync: Int
}
