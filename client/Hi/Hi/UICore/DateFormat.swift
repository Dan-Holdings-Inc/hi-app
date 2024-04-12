//
//  DateFormat.swift
//  Hi
//
//  Created by Yuma on 2024/04/11.
//

import Foundation

class DateFormat {
    func dateToString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH : mm"
        return dateFormatter.string(from: date)
    }
}
