//
//  UserRepository.swift
//  Order
//
//  Created by anh on 2024/11/14.
//

import Foundation
import Combine

class UserRepository {
    func preLogin(loginRequest: LoginRequest) -> AnyPublisher<LoginState, NetworkError> {
        UserApi().preLogin(loginRequest)
            .map { loginResponse in
                LoginState.preLogin(LoginState.PreLogin(key: "", request: loginRequest, response: loginResponse))
            }
            .eraseToAnyPublisher()
    }
    func login (loginRequest: LoginRequest) -> AnyPublisher<LoginState, NetworkError> {
        UserApi().login(loginRequest)
            .map { loginResponse in
                guard let u = loginResponse.toUserWithToken() else {
                    return LoginState.err(LoginState.Err(error: NetworkError.getNil))
                }
                let v = switch u {
                case .Value( let t):
                    if t.userInfo.appAuthority == 0 {
                        LoginState.disabled
                    } else {
                        LoginState.ok(LoginState.Ok(user: t, json: loginResponse))
                    }
                case .Error(let e):
                    LoginState.err(LoginState.Err(error: e))
                case .Loading:
                    LoginState.err(LoginState.Err(error: NetworkError.getNil))
                }
                return v
            }
            .eraseToAnyPublisher()
    }
}
