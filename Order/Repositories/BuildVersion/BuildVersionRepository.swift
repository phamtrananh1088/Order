//
//  BuildVersionRepository.swift
//  Order
//
//  Created by anh on 2024/11/21.
//

import Foundation

class BuildVersionRepository {
    var buildVersionDao: BuildVersionDao {
        return Current.shared.resultDB.buildVersionDao
    }
    
    func getVersion() -> BuildVersion? {
        return buildVersionDao.getVersion()
    }
    func initDatabase() {
        let resultDB = Current.shared.resultDB
        if !resultDB.exist() {
            do {
                let _ = resultDB.makeDb()
                try resultDB.createAllTable()
                buildVersionDao.insert(entity: BuildVersion(releaseVersion: "\(Bundle.main.infoDictionary!["CFBundleShortVersionString"]!)", buidNumber: "\(Bundle.main.infoDictionary!["CFBundleVersion"]!)" , buildName: nil))
            } catch {
                print(error)
            }
        } else {
            if let ver = getVersion() {
                if ver.releaseVersion == Bundle.main.infoDictionary!["CFBundleShortVersionString"]! as! String && ver.buidNumber == Bundle.main.infoDictionary!["CFBundleVersion"]! as! String {
//                    nothing
                } else {
                    do {
                        try resultDB.dropDb()
                        try resultDB.createAllTable()
                        buildVersionDao.updateOrIgnore(entity: BuildVersion(releaseVersion: "\(Bundle.main.infoDictionary!["CFBundleShortVersionString"]!)", buidNumber: "\(Bundle.main.infoDictionary!["CFBundleVersion"]!)" , buildName: nil))
                    } catch {
                        print(error)
                    }
                }
            }
        }
    }
}
