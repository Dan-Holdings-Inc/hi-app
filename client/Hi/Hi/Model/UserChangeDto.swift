//
//  UserChangeDto.swift
//  Hi
//
//  Created by ryosei on 2024/04/26.
//

struct UserChangeDto: Codable {
    var _id: String
    var email: String
    var userName: String
    var name: String
    var getUpAt: String
    var daysToAlarm: [Bool]
}
