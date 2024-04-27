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
