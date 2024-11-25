//
//  ClientInfo.swift
//  Order
//
//  Created by anh on 2024/11/11.
//

import Foundation
import UIKit
import CryptoKit

struct ClientInfo: Codable {
    var terminalId : String
    var terminalName: String
    var osVersion: String
    var appVersion: String
    
    static func create() -> Self {
        var terminalId : String {
            let data = Data((UIDevice.current.identifierForVendor?.uuidString ?? "").utf8)
            let hash = Insecure.MD5.hash(data: data)
            let md5 = hash.map { String(format: "%02hhx", $0)}.joined()
            return String(md5.prefix(16))
        }
        let terminalName: String = "iOS"
        let osVersion: String = ProcessInfo.processInfo.operatingSystemVersionString
        let appVersion: String = (Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String) ?? "" + "." + ((Bundle.main.infoDictionary?["CFBundlerVersion"] as? String) ?? "")
        return ClientInfo(terminalId: terminalId, terminalName: terminalName, osVersion: osVersion, appVersion: appVersion)
    }
}
