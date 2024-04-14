//
//  KeyChainHelper.swift
//  Hi
//
//  Created by Yuma on 2024/04/14.
//

import Foundation

class KeyChainHelper {
    
    static let shared = KeyChainHelper()
    private init() {}
    
    func save(_ data: Data, service: String, account: String) -> Bool {
        let query = [
            kSecValueData: data,
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: account,
        ] as CFDictionary
        
        let matchingStatus = SecItemCopyMatching(query, nil)
        switch matchingStatus {
        case errSecItemNotFound:
            // データが存在しない場合は保存
            let status = SecItemAdd(query, nil)
            return status == noErr
        case errSecSuccess:
            // データが存在する場合は更新
            SecItemUpdate(query, [kSecValueData as String: data] as CFDictionary)
            return true
        default:
            return false
        }
    }
    
    func read(service: String, account: String) -> String? {
        let query = [
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecClass: kSecClassGenericPassword,
            kSecReturnData: true
        ] as CFDictionary
        
        var result: AnyObject?
        SecItemCopyMatching(query, &result)
        
        if let data = (result as? Data) {
            return String(data: data, encoding: .utf8)
        } else {
            return nil
        }
    }
    
    func delete(service: String, account: String) -> Bool {
        let query = [
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecClass: kSecClassGenericPassword,
        ] as CFDictionary
        
        let status = SecItemDelete(query)
        return status == noErr
    }
}
