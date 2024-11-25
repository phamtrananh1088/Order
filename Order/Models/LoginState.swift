//
//  LoginState.swift
//  Order
//
//  Created by anh on 2024/11/14.
//

import Foundation

enum LoginState {
    case disabled
    case loading
    case preLogin(LoginState.PreLogin)
    case err(LoginState.Err)
    case ok(LoginState.Ok)
    
    struct PreLogin {
        let key: String
        let request: LoginRequest
        let response: LoginResponse
    }
    
    struct Err {
        let error: Error
    }
    
    struct Ok {
        let user: UserWithToken
        let json: LoginResponse
    }
}
