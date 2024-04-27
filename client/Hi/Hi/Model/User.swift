//
//  User.swift
//  Hi
//
//  Created by Yuma on 2024/04/26.
//

import Foundation

struct User: Codable, Hashable {
    var _id: String
    var email: String
    var userName: String
    var name: String
    var __v: Int
}

struct Time: Codable{
    var _id:String
    var userId:String
    var getUpAt: String
    var daysToAlarm: [Bool]
    var __v: Int
}
