//
//  NetworkError.swift
//  Order
//
//  Created by anh on 2024/11/15.
//

import Foundation
import SwiftUI

protocol Messagable {
    func errMessage() -> String
}
enum NetworkError: Error, Messagable {
    func errMessage() -> String {
        return switch self {
        case .serverError:
            "internal_server_errror"
        case .otherLoggedIn:
            "other_loggedin"
        case .resourceNotFound:
            "network resource not found"
        case .getNil:
            "nil"
        case .urlError(let err ):
            urlErrorgetMessage(err)
        case .otherError(_):
            "network_error"
        }
    }
    private func urlErrorgetMessage(_ err: URLError) -> String {
        return err.localizedDescription
    }
    case serverError
    case otherLoggedIn
    case resourceNotFound
    case getNil
    case urlError(err: URLError)
    case otherError(err: Error)
}
