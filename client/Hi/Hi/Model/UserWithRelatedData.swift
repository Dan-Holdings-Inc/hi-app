//
//  UserRegistrationDto.swift
//  Hi
//
//  Created by Yuma on 2024/04/21.
//

struct UserWithRelatedData: Codable {
    var _id: String
    var email: String
    var userName: String
    var name: String
    var getUpAt: String
    var daysToAlarm: [Bool]
    var followers: [User]
    var followings: [User]
}
