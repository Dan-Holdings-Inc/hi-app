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
                case .failure(let error):
                    print("Failed with: \(error.localizedDescription)")
                }
            }
    }
}

