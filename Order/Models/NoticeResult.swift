//
//  NoticeResult.swift
//  Order
//
//  Created by anh on 2024/11/21.
//

import Foundation

struct NoticeResult: Codable {
    let notices: [Notice]
    let clientInfo: ClientInfo?
}
