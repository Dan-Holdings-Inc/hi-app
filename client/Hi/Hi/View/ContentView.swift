//
//  ContentView.swift
//  Hi
//
//  Created by Yuma on 2024/04/08.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var service: Auth0Service
    @AppStorage("isFirstLogin") var isFirstLogin = true
    
    var body: some View {
        if service.isAuthenticated {
            if isFirstLogin {
                AccountCreateNameView()
            } else {
                MainTabBar()
            }
        } else {
            LoginView()
        }
    }
}

#Preview {
    ContentView()
}
