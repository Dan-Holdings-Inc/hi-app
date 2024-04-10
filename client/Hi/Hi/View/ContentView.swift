//
//  ContentView.swift
//  Hi
//
//  Created by Yuma on 2024/04/08.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var service: Auth0Service
    
    var body: some View {
        if service.isAuthenticated {
            MainTabBar()
        } else {
            LoginView()
        }
    }
}

#Preview {
    ContentView()
}
