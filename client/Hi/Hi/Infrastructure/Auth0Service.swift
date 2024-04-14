//
//  Auth0Service.swift
//  Hi
//
//  Created by Yuma on 2024/04/10.
//

import Foundation
import Auth0

class Auth0Service: ObservableObject {
    @Published var isAuthenticated = false
    @Published var userProfile = Profile.empty
    
    let keychainServise = "idToken"
    let keychainAccount = "auth0"
    
    internal func login() {
        Auth0
            .webAuth()
            .start { result in
                switch result {
                case .success(let credentials):
                    print("Obtained credentials: \(credentials)")
                    self.isAuthenticated = true
                    // 型定義に当てはめる部分のはずだが、エラーが出るので一旦コメントアウト
//                    self.userProfile = Profile.from(credentials.idToken)
                    if KeyChainHelper.shared.save(credentials.idToken.data(using: .utf8)!, service: self.keychainServise, account: self.keychainAccount) {
                        print("keychainにidTokenを保存")
                    } else {
                        print("idTokenの保存失敗")
                    }
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
                    self.userProfile = Profile.empty
                    if KeyChainHelper.shared.delete(service: self.keychainServise, account: self.keychainAccount) {
                        print("keychainからidTokenを削除")
                    } else {
                        print("idTokenの削除に失敗")
                    }
                case .failure(let error):
                    print("Failed with: \(error.localizedDescription)")
                }
            }
    }
}

