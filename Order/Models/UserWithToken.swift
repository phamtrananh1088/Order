//
//  UserWithToken.swift
//  Order
//
//  Created by anh on 2024/11/11.
//

import Foundation

struct UserWithToken: Decodable {
    let userInfo: UserInfo
    let token: String
    let uid: String?
}
