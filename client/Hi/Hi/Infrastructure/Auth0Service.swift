//
//  Auth0Service.swift
//  Hi
//
//  Created by Yuma on 2024/04/10.
//

import Foundation
import Auth0
import JWTDecode
import SimpleKeychain

class Auth0Service: ObservableObject {
    @Published var isAuthenticated = false
    
    let keychain = SimpleKeychain(service: "Auth0")
    let userDefaults = UserDefaultsHelper()
    
    internal func login() {
        Auth0
            .webAuth()
            .scope("openid profile offline_access")
            .start { result in
                switch result {
                case .success(let credentials):
                    guard let refreshToken = credentials.refreshToken else {
                        print("refreshTokenがありません")
                        return
                    }
                    print(credentials.idToken)
                    print("Obtained credentials: \(credentials)")
                    
                    let jwt = try! decode(jwt: credentials.idToken)
                    let email = jwt.claim(name: "name").string ?? ""
                    self.userDefaults.set(value: email, key: "email")
                    
                    do {
                        try self.keychain.set(credentials.accessToken, forKey: "access_token")
                        try self.keychain.set(refreshToken, forKey: "refresh_token")
                    } catch {
                        print("keychainへの保存に失敗")
                    }
                    
                    self.isAuthenticated = true
                case .failure(let error):
                    print("Failure: \(error.localizedDescription)")
                }
            }
    }
    
    internal func logout(){
        Auth0
            .webAuth()
            .clearSession { result in
                switch result {
                case .success:
                    print("Session cookie cleared")
                    self.isAuthenticated = false
                    do {
                        try self.keychain.deleteAll()
                    } catch {
                        print("keychainの削除失敗")
                    }
                case .failure(let error):
                    print("Failed with: \(error.localizedDescription)")
                }
            }
    }
    
    func resetAuthenticated() {
        isAuthenticated = false
    }
}

