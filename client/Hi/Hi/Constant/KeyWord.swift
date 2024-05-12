//
//  KeyWord.swift
//  Hi
//
//  Created by Yuma on 2024/05/09.
//

import Foundation

// UserDefaultsのkeyを管理
enum UserDefaultsKey {
    // ユーザー情報
    static let id = "id"
    static let name = "name"
    static let userName = "userName"
    static let getUpAt = "getUpAt"
    static let dayToAlarm = "dayToAlarm"
    
    // Auth0
    static let idToken = "idToken"
    static let email = "email"
    
    static let deviceToken = "deviceToken"
}
