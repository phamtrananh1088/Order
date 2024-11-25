//
//  Config.swift
//  Order
//
//  Created by anh on 2024/11/11.
//

import Foundation

struct Config {
    static let pref = Pref()
    static let env = Environment()
    static let clientInfo = ClientInfo.create()
    private init(){}
}
struct Pref {
    var lastUser: String? {
        get {
            return UserDefaults.standard.string(forKey: Pref.KEY_LAST_USER)
        }
    }
    var lastApiKey: String? {
        get {
            return UserDefaults.standard.string(forKey: Pref.KEY_LAST_API_KEY)
        }
    }
    var lastUserCompany: String? {
        get {
            return UserDefaults.standard.string(forKey: Pref.KEY_LAST_USER_COMPANY)
            
        }
    }
    var lastWeather: Int {
        get {
            return UserDefaults.standard.integer(forKey: Pref.KEY_LAST_WEATHER)
        }
    }
    var uid: String? {
        get {
            UserDefaults.standard.string(forKey: Pref.KEY_USER_UID)
        }
    }
    
    var language: String? {
        get {
            guard let a = UserDefaults.standard.array(forKey: Pref.APPLE_LANGUAGES), !a.isEmpty, let s = a[0] as? String else {
                return nil
            }
            return s
        }
    }
    
    static private let KEY_LAST_USER = "KEY_LAST_USER"
    static private let KEY_LAST_API_KEY = "KEY_LAST_API_KEY"
    static private let KEY_LAST_USER_COMPANY = "KEY_LAST_USER_COMPNAY"
    static private let KEY_LAST_WEATHER = "KEY_LAST_WEATHER"
    static private let KEY_USER_UID = "KEY_USER_UID"
    static private let APPLE_LANGUAGES = "AppleLanguages"
    func setUserToken(u: UserWithToken) -> Void {
        let userInfo = u.userInfo
        UserDefaults.standard.setValue(userInfo.userId, forKey: Pref.KEY_LAST_USER)
        UserDefaults.standard.setValue(u.token, forKey: Pref.KEY_LAST_API_KEY)
        UserDefaults.standard.setValue(userInfo.companyCd, forKey: Pref.KEY_LAST_USER_COMPANY)
        UserDefaults.standard.setValue(u.uid, forKey: Pref.KEY_USER_UID)
    }
    
    func setLanguage(languageCode: String) {
        UserDefaults.standard.set([languageCode], forKey: Pref.APPLE_LANGUAGES)
    }
    
    func setWeather(weather: Int) {
        UserDefaults.standard.set(weather, forKey: Pref.KEY_LAST_WEATHER)
    }
}

enum language: String {
    case english = "en"
    case japan = "ja"
}

struct Environment {
    var app_center_key: String {
        if let value = ProcessInfo.processInfo.environment[Environment.app_center_key] {
            return value
        }
        print("couldn't get environment app_center_key")
        return ""
    }
    var api: String {
        if let value = ProcessInfo.processInfo.environment[Environment.api] {
            return value
        }
        print("couldn't get environment api")
        return ""
    }
    var api_msg: String {
        if let value = ProcessInfo.processInfo.environment[Environment.api_msg] {
            return value
        }
        print("couldn't get environment api_msg")
        return ""
    }
    var msg_api_key: String {
        if let value = ProcessInfo.processInfo.environment[Environment
            .msg_api_key] {
            return value
        }
        print("couldn't get environment msg_api_key")
        return ""
    }
    static private let app_center_key = "app_center_key"
    static private let api = "api"
    static private let api_msg = "api_msg"
    static private let msg_api_key = "msg_api_key"
    
    let retry: Int = 5
}
