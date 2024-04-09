//
//  SettingView.swift
//  Hi
//
//  Created by Yuma on 2024/04/09.
//

import SwiftUI

struct SettingView: View {
    @EnvironmentObject var router: NavigationRouter
    
    var body: some View {
        LogoutButton(action: {
            router.backPage()
        })
    }
}

#Preview {
    SettingView()
}
