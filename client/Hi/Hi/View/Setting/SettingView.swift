//
//  SettingView.swift
//  Hi
//
//  Created by Yuma on 2024/04/09.
//

import SwiftUI

struct SettingView: View {
    @EnvironmentObject var router: NavigationRouter
    @EnvironmentObject var service: Auth0Service
    
    var body: some View {
        VStack {
            LogoutButton(action: {
                service.logout()
            })
        }
        .onChange(of: service.isAuthenticated) {
            if !service.isAuthenticated {
                router.navigateToView(destination: .login)
            }
        }
    }
}

#Preview {
    SettingView()
}
