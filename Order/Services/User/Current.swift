//
//  Current.swift
//  Order
//
//  Created by anh on 2024/11/11.
//

import Foundation
import GRDB
import UIKit

class Current {
    static let shared = Current()
    private init() {}
    private(set) var user: LoggedUser? = nil
    private var sync: SyncData? = nil
    
    lazy var resultDB: ResultDb = {
        return ResultDb(databasePath: FileHelper.default.userDir.appendingPathComponent("result_db.sqlite", conformingTo: .fileURL).path)
    }()
    
    func login(login: UserWithToken, json: LoginResponse) -> Void {
        let o = user?.userInfo
        self.login(login)
        o?.removeLoginData()
        setLastUser(user: login, json: json)
    }
    
    func setLastUser(user: UserWithToken, json: LoginResponse) -> Void {
        let userInfo = user.userInfo
        Config.pref.setUserToken(u: user)
        userInfo.saveLoginData(json: json)
        
    }

    func tryLoginFromSavedInfo() {
        if let user = readUserInfoFromLocal() {
            login(user)
        }
    }
    
    func readUserInfoFromLocal() -> UserWithToken? {
        guard let company = Config.pref.lastUserCompany else { return nil }
        guard let userId = Config.pref.lastUser else { return nil }
        let url = UserInfo.userJsonFile(company, userId)
        guard FileManager.default.fileExists(atPath: url.path) else {
            return nil
        }

        if let lo: LoginResponse = FileHelper.default.read(url: url) {
            return lo.toUserWithToken()?.getOrNull()
        } else {
            return nil
        }
    }
    
    private func setUser(_ u: UserWithToken?) {
        sync = nil
        user = nil
        if let u = u {
            user = LoggedUser(userInfo: u.userInfo, token: u.token)
            if let db = user?.userDB, !db.exist() {
                do {
                    let _ = db.makeDb()
                    try db.createAllTable()
                } catch {
                    print(error)
                }
            }
        }
        // PushMessge clear notify
    }
    
    private func login(_ user: UserWithToken) {
        setUser(user)
//        if let u = self.user {
////            let m = MessageTask(u)
////            m.observePendingChanges()
//        }
        
//        syncMaster()
//        UpdateFirebaseToken.updateToken()
    }
    
    func logout(removeHome: Bool = false) {
        let old = user
        setUser(nil)
        if let old = old {
            old.userInfo.removeLoginData()
        }
    }

    func restart() {
        setUser(nil)
    }
}
