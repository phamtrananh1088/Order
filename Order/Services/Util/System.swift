//
//  System.swift
//  Order
//
//  Created by anh on 2024/11/21.
//

import Foundation

struct System {
    private init(){}
    
    static func currentTimeMillis() -> Int64 {
        let current = Date()
        return Int64(current.timeIntervalSince1970 * 1000)
    }
    
    static func currentDateDayInWeek() -> String {
        return format(date: Date(), dateformat: DateFormat.dayOfWeek.rawValue)
    }
    
    static func currentDateDayInWeek2() -> String {
        return format(date: Date(), dateformat: DateFormat.dayOfWeek2.rawValue)
    }
    
    private static func format(date: Date, dateformat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ja_JP")
        dateFormatter.dateFormat = dateformat
        
        let dateFormatString = dateFormatter.string(from: date)
        return dateFormatString
    }
    
    enum DateFormat: String {
        case dayOfWeek = "MM月dd日 (EE)"
        case dayOfWeek2 = "MM月dd日 (EEEE)"
    }
}
