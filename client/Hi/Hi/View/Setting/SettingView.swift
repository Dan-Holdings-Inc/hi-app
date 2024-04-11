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
            let labels = ["名前", "ユーザーID", "起きる時間", "曜日"]
            ForEach(0 ..< labels.count, id: \.self) { index in
                SettingCard(label: "\(labels[index])", action: {
                    router.navigateToView(destination: router.settingNavigationPath[index])
                })
            }
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

// 以降、各種設定画面への遷移後のビュー
struct SettingNameView: View {
    @EnvironmentObject var router: NavigationRouter
    
    var body: some View {
        AccountSettingName(nextButtonLabel: "変更する", isShowBackButton: true, action: {
            router.backPage()
        })
        .navigationBarHidden(true)
    }
}

struct SettingUserIDView: View {
    @EnvironmentObject var router: NavigationRouter
    
    var body: some View {
        AccountSettingUserID(nextButtonLabel: "変更する", action: {
            router.backPage()
        })
        .navigationBarHidden(true)
    }
}

struct SettingWakeUpTimeView: View {
    @EnvironmentObject var router: NavigationRouter
    
    var body: some View {
        AccountSettingWakeUpTime(nextButtonLabel: "変更する", action: {
            router.backPage()
        })
        .navigationBarHidden(true)
    }
}

struct SettingDayOfWeekView: View {
    @EnvironmentObject var router: NavigationRouter
    
    var body: some View {
        AccountSettingDayOfWeek(nextButtonLabel: "変更する", action: {
            router.backPage()
        })
        .navigationBarHidden(true)
    }
}

#Preview {
    SettingView()
}
