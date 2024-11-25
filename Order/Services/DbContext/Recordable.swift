//
//  Record.swift
//  Order
//
//  Created by anh on 2024/11/20.
//

import Foundation
import GRDB

typealias Recordable = Codable & PersistableRecord & FetchableRecord
