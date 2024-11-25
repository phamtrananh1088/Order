//
//  BinHeader.swift
//  Order
//
//  Created by anh on 2024/11/06.
//

import Foundation
import GRDB
import EnjoyMacro

@createTable("binHeader", "allocationNo")
struct BinHeader: Recordable, SyncRecord, TableSchema {
    var allocationNo: String
    var truck: String
    var sync: Int
}
