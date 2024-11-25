//
//  File.swift
//  Order
//
//  Created by anh on 2024/11/21.
//

import Foundation
import EnjoyMacro

@createTable("buildVersion", "releaseVersion, buidNumber")
struct BuildVersion: Recordable, TableSchema {
    var releaseVersion: String
    var buidNumber: String
    var buildName: String?
}
