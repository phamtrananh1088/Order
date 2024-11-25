//
//  LoginView.swift
//  Order
//
//  Created by anh on 2024/11/12.
//

import Foundation
import SwiftUI

struct LoginView: View {
    @ObservedObject var loginVm: LoginViewModel
    var login: (LoginState.Ok) -> Void
    
    private var state: LoginState? {
        return loginVm.loginState
    }
    private var loading: Bool {
        guard let state = state else {
            return false
        }
        return switch state {
        case .loading, .preLogin(_), .ok(_):
            true
        default:
            false
        }
    }
    @State private var prelogin: Bool = false
    @State private var isShowConfirm2: Bool = false
    @State private var errorMessage: (String, String)? = nil
    @State private var isShowError: Bool = false
    @State private var errMessage: String? = nil
    @State private var isValidate: Bool = false
    
    init(loginVm: LoginViewModel, login: @escaping (LoginState.Ok) -> Void) {
        self.login = login
        self.loginVm = loginVm
    }
    private func getErrorMessage(err: LoginState.Err) -> (String, String)? {
        var e: (String, String)?
        if let l = err.error as? LoginException {
            e = switch l  {
            case .message(let messageCode):
                switch messageCode {
                case "401.1", "401.2":
                    ("login_auth_err", "login_auth_wrong_msg")
                case "401.3":
                    ("", "login_auth_password_expired_msg")
                case "401.5":
                    ("login_auth_err", "login_auth_invalid_account_msg")
                default:
                    nil
                }
            }
        }
        return e
    }
    
    var body: some View {
        ZStack {
            if case .preLogin(let pre) = state {
                if pre.response.loginResult.isLoggedIn {
                    Color.cyan.opacity(0.01).onAppear {
                        prelogin = true
                    }
                    .alert("", isPresented: $prelogin, actions: {
                        Button("yes") {
                            loginVm.login(prelogin: pre)
                        }
                        Button(role: .cancel, action: {
                            loginVm.loginState = nil
                        }, label: {
                            Text("no")
                        })
                    }, message: {
                        Text("login_sso_alert_msg")
                    })
                } else {
                    Color.cyan.opacity(0.01).onAppear {
                        loginVm.login(prelogin: pre)
                    }
                }
            } else if case .err(let err) = state {
                if let e = getErrorMessage(err: err) {
                    Color.cyan.opacity(0.01).onAppear {
                        isShowConfirm2 = true
                        errorMessage = e
                    }
                } else {
                    Color.cyan.opacity(0.01).onAppear {
                        loginVm.loginState = nil
                        isShowError = true
                        errMessage = (err.error as? NetworkError)?.errMessage()
                    }
                }
            } else if case .disabled = state {
                Color.cyan.opacity(0.01).onAppear {
                    isShowConfirm2 = true
                    errorMessage = ("", "login_disabled")
                }
            } else if case .ok(let OK) = state {
               let _ = loginOk(OK)
            }
            
            Color.cyan
            VStack {
                VStack(spacing: 32) {
                    Spacer()
                        .frame(height: 80)
                    Text("app name")
                        .font(.system(.title))
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                        .padding(.bottom, 16)
                    VStack(spacing: 16) {
                        ItemTextFieldBuilder(content: {
                            TextField("", text: $loginVm.companyCd)
                        },title: "company id", text: $loginVm.companyCd, isValidate: $isValidate)
                        
                        ItemTextFieldBuilder(content: {
                            TextField("", text: $loginVm.userId)
                        },title: "user id", text: $loginVm.userId, isValidate: $isValidate)
                        
                        ItemTextFieldBuilder(content: {
                            SecureField("", text: $loginVm.password)
                        },title: "password", text: $loginVm.password, isValidate: $isValidate)
                        
                    }
                    ZStack {
                        if loading {
                            LightingProgressView()
                        } else {
                            HeadButtonView(text: "Login") {
                                let validate = !(loginVm.companyCd.isEmpty || loginVm.userId.isEmpty || loginVm.password.isEmpty)
                                isValidate = true
                                if validate {
                                    loginVm.preLogin(companyCd: loginVm.companyCd, userId: loginVm.userId, password: loginVm.password)
                                }
                            }
                        }
                    }
                    .frame(height: 50)
                    
                    Text("login_footer_info")
                        .font(.system(.body))
                        .foregroundStyle(.white)
                        .multilineTextAlignment(.center)
                    Spacer()

                    Text("terminal id \(Config.clientInfo.terminalId)")
                        .font(.system(.caption2))
                        .foregroundStyle(.white)
                        .frame(height: 80)
                }
                .padding(.horizontal, 40)
            }
            .alert(LocalizedStringKey(errorMessage?.0 ?? ""), isPresented: $isShowConfirm2, actions: {
                Button("yes") {
                    loginVm.loginState = nil
                }
            }, message: {
                Text(LocalizedStringKey(errorMessage?.1 ?? ""))
            })
            .overlay(
                SnackbarView(isPresented: $isShowError, message: errMessage ?? "")
            )
        }
        .ignoresSafeArea()
    }
    
    private func loginOk(_ OK: LoginState.Ok) {
        DispatchQueue.main.async {
            isValidate = false
        }
        self.login(OK)
    }
}

private struct ItemTextFieldBuilder<Content: View>: View {
    @ViewBuilder var content: () -> Content
    var title: String
    @Binding var text: String
    @Binding var isValidate: Bool
    @FocusState private var isFocused: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            ZStack(alignment: .topLeading) {
                HStack{}
                    .frame(maxWidth: .infinity, minHeight: 60)
                    .border(isFocused ? .white : (isValidate && text.isEmpty ? .error.opacity(0.5) : .white.opacity(0.5)), width: isFocused ? 2 : 1)
                    .cornerRadius(4)

                    Text(LocalizedStringKey(title))
                    .font(.system(isFocused || !text.isEmpty ? .caption2 : .body))
                    .foregroundStyle(isFocused || !text.isEmpty ? .white : (isValidate && text.isEmpty ? .error.opacity(0.5) : .white.opacity(0.5)))
                        .padding(EdgeInsets(top: isFocused || !text.isEmpty ? 8 : 20, leading: 16, bottom: 0, trailing: 0))

                        .animation(.linear, value: isFocused)
                
                content()
                    .focused($isFocused)
                    .font(.system(.body))
                    .foregroundStyle(.white)
                    .padding()
                    .padding(.top, 12)
                   
                
            }
            if isValidate && text.isEmpty {
                Text("\(title) field_required")
                    .font(.system(.body))
                    .foregroundStyle(.error)
            }
        }
        .onTapGesture {
            isFocused = true
        }
    }
}

