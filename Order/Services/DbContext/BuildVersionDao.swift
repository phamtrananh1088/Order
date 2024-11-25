//
//  BuildVersionDao.swift
//  Order
//
//  Created by anh on 2024/11/21.
//

import Foundation

class BuildVersionDao: CommonDao<BuildVersion> {
    func getVersion() -> BuildVersion? {
        return read(sql: "select * from buildVersion").first
    }
}
