//
//  ResultAPI.swift
//  Order
//
//  Created by anh on 2024/11/12.
//

import Foundation

enum ResultAPI<T> {
    case Loading
    case Value(T)
    case Error(Error)
    
    func getOrNull() -> T? {
        switch self {
        case .Loading, .Error( _):
            return nil
        case .Value(let r):
            return r
        }
    }
}
