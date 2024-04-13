//
//  UserDefaultsHelper.swift
//  Hi
//
//  Created by Yuma on 2024/04/13.
//

import Foundation

class UserDefaultsHelper {
    let userDefaults = UserDefaults.standard
    
    func set(value: Any, key: String) {
        userDefaults.set(value, forKey: key)
    }
    
    func getStringData(key: String) -> String {
        return userDefaults.string(forKey: key) ?? ""
    }
    
    func getBoolData(key: String) -> Bool {
        return userDefaults.bool(forKey: key)
    }
    
    func remove(key: String) {
        userDefaults.removeObject(forKey: key)
    }
    
    func removeUserDefaults() {
        if let appDomain = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: appDomain)
        }
    }
}
