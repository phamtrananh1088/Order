//
//  LoginViewModel.swift
//  Order
//
//  Created by anh on 2024/11/12.
//

import Foundation
import Combine

class LoginViewModel: ObservableObject {
    @Published var companyCd: String = ""
    @Published var userId: String = ""
    @Published var password: String = ""
    @Published var loginState: LoginState?
    private let userRepository = UserRepository()
    private var cancellables = Set<AnyCancellable>()
    
    init(defaultCompantCd: String) {
        companyCd = defaultCompantCd
    }
    
    func preLogin(companyCd: String, userId: String, password: String) -> Void {
        let request = LoginRequest(userId: userId, companyCd: companyCd, password: password, clientInfo: Config.clientInfo)
        self.loginState = LoginState.loading
        userRepository.preLogin(loginRequest: request)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case let .failure(failure) = completion {
                    self.loginState = LoginState.err(LoginState.Err(error: failure))
                }
            }, receiveValue: { data in
                self.loginState = data
            })
            .store(in: &cancellables)
    }
    
    func login(prelogin: LoginState.PreLogin) -> Void {
        let request = LoginRequest(userId: prelogin.request.userId, companyCd: prelogin.request.companyCd, password: prelogin.request.password, clientInfo: Config.clientInfo)
        self.loginState = LoginState.loading
        userRepository.login(loginRequest: request)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case let .failure(failure) = completion {
                    self.loginState = LoginState.err(LoginState.Err(error: failure))
                }
            }, receiveValue: { data in
                self.loginState = data
            })
            .store(in: &cancellables)
    }
}
