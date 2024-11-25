//
//  LoginRequest.swift
//  Order
//
//  Created by anh on 2024/11/14.
//

import Foundation

struct LoginRequest: Codable {
    let userId: String
    let companyCd: String
    let password: String
    let clientInfo: ClientInfo
}
