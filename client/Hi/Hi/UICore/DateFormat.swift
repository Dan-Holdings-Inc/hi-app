//
//  DateFormat.swift
//  Hi
//
//  Created by Yuma on 2024/04/11.
//

import Foundation

class DateFormat {
    let dateFormatter = DateFormatter()
    
    func dateToString(date: Date) -> String {
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Tokyo")
        
        let string = dateFormatter.string(from: date)
        return string
    }
    
    func StringToDate(string: String) -> Date {
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Tokyo")
        
        let date = dateFormatter.date(from: string) ?? Date()
        return date
    }
}
