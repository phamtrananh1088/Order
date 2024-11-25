//
//  LoginResponse.swift
//  Order
//
//  Created by anh on 2024/11/12.
//

import Foundation

struct LoginResponse: Codable {
    let loginResult: LR
    let userInfo: UserInfo?
    
    func toUserWithToken() -> ResultAPI<UserWithToken>? {
        let l = loginResult
        if l.isLoggedIn {
            guard let u = userInfo, let token = l.token else {
                return nil
            }
            return ResultAPI.Value(UserWithToken(userInfo: u, token: token, uid: l.uid))
        } else {
            return ResultAPI.Error(LoginException.message(l.messageCode))
        }
    }
}
struct LR: Codable {
    let isLoggedIn: Bool
    let messageCode: String
    let token: String?
    let uid: String?
}
