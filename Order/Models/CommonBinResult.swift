//
//  CommonBinResult.swift
//  Order
//
//  Created by anh on 2024/11/07.
//

import Foundation
import GRDB
import EnjoyMacro

@createTable("commonBinResult", "allocationNo")
struct CommonBinResult: Recordable, TableSchema {
    var allocationNo: String
    var truct: String
}
