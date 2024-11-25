//
//  NoticePost.swift
//  Order
//
//  Created by anh on 2024/11/20.
//

import Foundation

struct NoticePost: Codable {
    let notices: [CommonNotice]
    let clientInfo: ClientInfo
}
