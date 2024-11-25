//
//  SyncRecord.swift
//  Order
//
//  Created by anh on 2024/11/06.
//

import Foundation

protocol SyncRecord {
    var sync: Int {get set}
    mutating func recordChange() -> Void
    mutating func setSyncFinished()
}
extension SyncRecord {
    mutating func setSyncFinished() {
        sync = SyncStatus.done.rawValue
    }
    mutating func recordChange() {
        sync = SyncStatus.changed.rawValue
    }
}
enum SyncStatus: Int {
    case pending = 0
    case changed = 1
    case done = 2
}
