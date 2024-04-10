//
//  SettingView.swift
//  Hi
//
//  Created by Yuma on 2024/04/09.
//

import SwiftUI

struct SettingView: View {
    @EnvironmentObject var service: Auth0Service
    
    var body: some View {
        LogoutButton(action: {
            service.logout()
        })
    }
}

#Preview {
    SettingView()
}
