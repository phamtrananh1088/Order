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
    static func getCaldendar() -> Calendar {
        var calendar = Calendar.current
        calendar.locale = Locale(identifier: "ja_JP")
        return calendar
    }
    static func getCurrentTime() -> (year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Int) {
        var calendar = Calendar.current
        calendar.locale = Locale(identifier: "ja_JP")
        let date = Date()
        return (calendar.component(.year, from: date),
                calendar.component(.month, from: date),
                calendar.component(.day, from: date),
                calendar.component(.hour, from: date),
                calendar.component(.minute, from: date),
                calendar.component(.second, from: date))
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
