//
//  TimeChangeDto.swift
//  Hi
//
//  Created by ryosei on 2024/04/27.
//

struct TimeChangeDto: Codable {
    var userId: String
    var getUpAt: String
    var daysToAlarm: [Bool]
}
