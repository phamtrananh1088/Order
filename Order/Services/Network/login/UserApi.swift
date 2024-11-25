//
//  UserApi.swift
//  Order
//
//  Created by anh on 2024/11/14.
//

import Foundation
import Combine

class UserApi {
    var baseApi : BaseApi
    init() {
        baseApi = BaseApi()
#if MOCK
        baseApi = MockBaseApi()
        #endif
        #if TOMOCK
baseApi = MockBaseApi()
#endif
        baseApi.builder  = { urlBuilder in
            let apiKey = Config.env.msg_api_key
            if #available(iOS 16, *) {
                urlBuilder.url.append(queryItems: [URLQueryItem(name: "api_key", value: apiKey)])
            } else {
                urlBuilder.url = urlBuilder.url.appendingPathComponent("&api_key=\(apiKey)")
            }
        }
    }
    
    func login(_ loginRequest: LoginRequest) -> AnyPublisher<LoginResponse, NetworkError> {
        return baseApi.post(endpoint: endpoint.login.rawValue, body: loginRequest)
    }
    
    func preLogin(_ loginRequest: LoginRequest) -> AnyPublisher<LoginResponse, NetworkError> {
        return baseApi.post(endpoint: endpoint.preLogin.rawValue, body: loginRequest)
    }
    
    enum endpoint: String {
        case login = "account/login"
        case preLogin = "account/prelogin"
    }
}
