//
//  UserDefaultsHelper.swift
//  Hi
//
//  Created by Yuma on 2024/04/13.
//

import Foundation

class UserDefaultsHelper {
    let userDefaults = UserDefaults.standard
    
    func setStringDeta(value: String, key: String) {
        userDefaults.set(value, forKey: key)
    }
    
    func getStringDeta(key: String) -> String {
        return userDefaults.string(forKey: key) ?? ""
    }
    
    func removeDeta(key: String) {
        userDefaults.removeObject(forKey: key)
    }
}
