//
//  Notice.swift
//  Order
//
//  Created by anh on 2024/11/20.
//

import Foundation
import GRDB
import EnjoyMacro

@createTable("notice", "recordId")
struct Notice: Recordable, SyncRecord, TableSchema {
    var recordId: String
    var grdRecordId: String
    var noticeCd: String?
    var eventRank: Int
    var publicationDateFrom: Int64?
    var publicationDateTo: Int64?
    var noticeTitle: String?
    var noticeText: String?
    var unreadFlag: Bool
    var readDatetime: Int64?
    var sync: Int = SyncStatus.pending.rawValue
}
extension Notice {
    var useCase: NoticeUseCase {
        if unreadFlag && eventRank == 1 && noticeTitle != nil && noticeTitle!.contains("\(Config.clientInfo.terminalId)") {
            if noticeText != nil && noticeText!.contains("{INITIALIZE}") {
                return NoticeUseCase.Logout
            } else {
                return NoticeUseCase.Restart
            }
        } else {
            return NoticeUseCase.None
        }
    }
}
enum NoticeUseCase: Int {
   case Logout = 1
   case Restart = 2
   case None = -1
    
    func clickable() -> Bool {
        switch self {
        case .None:
            false
        default:
            true
        }
    }
}

enum NoticeRank: Int {
    case Important_Notice = 1
    case Normal_Notice = 2
}
