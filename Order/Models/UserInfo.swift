//
//  UserInfo.swift
//  Order
//
//  Created by anh on 2024/11/07.
//

import Foundation

struct UserInfo: Codable {
    var companyCd: String
    var userId: String
    var carrierCd: String?
    var officeCd: String?
    var userNm: String
    var appAuthority: Int
    var branchTel: String
    var positionSendInterval: Int
    var positionGetInterval: Int
    var backgroundInterval: Int
    var decimationRange: Int
    var incidentalUseFlag: Int
    var meterInputFlag: Int
    var geofenceUseFlag: Int
    var stayTime: Int
    var misdeliveryMeterTo: String
    var detectStartTiming: String
    var restTime: Int
    var restDistance: Int
}
extension UserInfo {
    static func userJsonFile(_ companyCd: String, _ userId: String) -> URL {
        return FileHelper.default.homeDirFile(companyCd, userId).child(path: "login.json")
    }
    func removeLoginData() {
        let url = UserInfo.userJsonFile(self.companyCd, self.userId)
        FileHelper.default.delete(url: url)
    }
    func saveLoginData(json: LoginResponse) {
        let url = UserInfo.userJsonFile(self.companyCd, self.userId)
        FileHelper.default.createFile(url: url, data: json)
    }
}
