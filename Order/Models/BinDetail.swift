//
//  BinDetail.swift
//  Order
//
//  Created by anh on 2024/11/06.
//

import Foundation
import GRDB
import EnjoyMacro

@createTable("binDetail", "allocationNo, allocationRowNo")
struct BinDetail: Recordable, SyncRecord, TableSchema {
    var allocationNo: String
    var allocationRowNo: Int
    var sync: Int
}
