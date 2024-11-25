//
//  WeatherModel.swift
//  Order
//
//  Created by anh on 2024/11/24.
//

import Foundation

struct WeatherModel: Identifiable {
    var name: String
    var icon: String
    var value: Int
    var id: String {"\(value)"}
}

enum WeatherState: Int {
    case hare = 1
    case kumori = 2
    case ame = 3
    case yuki = 4
    case harekumori = 5
    case kumorihare = 6
}
