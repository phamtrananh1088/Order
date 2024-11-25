//
//  LoggedUser.swift
//  Order
//
//  Created by anh on 2024/11/07.
//

import Foundation
import GRDB

class LoggedUser {
    let userInfo: UserInfo
    let token: String
    
    lazy var userDB: UserDb = {
        UserDb(databasePath: homeDir.appendingPathComponent("user_db.sqlite", conformingTo: .fileURL).path)
    }()
    let homeDir: URL
    init(userInfo: UserInfo, token: String) {
        self.userInfo = userInfo
        self.token = token
        homeDir = FileHelper.default.homeDirFile(userInfo.companyCd, userInfo.userId)
    }
    
    func close() ->Void {

    }
}
