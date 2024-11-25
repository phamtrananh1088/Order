//
//  Extension.swift
//  Order
//
//  Created by anh on 2024/11/12.
//

import Foundation

extension URL {
    func child(path: String) -> URL {
        var childDirectory: URL
        if #available(iOS 16, *) {
            childDirectory = appending(path: path)
        } else {
            childDirectory = appendingPathComponent(path)
        }
        return childDirectory
    }
}
