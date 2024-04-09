//
//  ContentView.swift
//  Hi
//
//  Created by Yuma on 2024/04/08.
//

import SwiftUI

struct ContentView: View {
    @StateObject var router = NavigationRouter()
    
    var body: some View {
        NavigationStack(path: $router.navigationPath) {
            LoginView()
                .navigationDestination(for: NavigationRouter.Path.self) { value in
                    switch value {
                    case .main:
                        MainTabBar()
                    case .login:
                        LoginView()
                    }
                }
                .navigationBarBackButtonHidden(true)
        }
        .environmentObject(router)
    }
}

#Preview {
    ContentView()
}
