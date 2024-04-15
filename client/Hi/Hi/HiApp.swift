//
//  HiApp.swift
//  Hi
//
//  Created by Yuma on 2024/04/08.
//

import SwiftUI

@main
struct HiApp: App {
    @StateObject var router = NavigationRouter()
    @StateObject var service: Auth0Service = Auth0Service()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.navigationPath) {
                ContentView()
                    .navigationDestination(for: NavigationRouter.Path.self) { value in
                        switch value {
                        case .main:
                            MainTabBar()
                        case .login:
                            LoginView()
                        case .accountCreateName:
                            AccountCreateNameView()
                        case .accountCreateUserID:
                            AccountCreateUserID()
                        case .accountCreateWakeUpTime:
                            AccountCreateWakeUpTimeView()
                        case .accountCreateDayOfWeek:
                            AccountCreateDayOfWeekView()
                        case .settingName:
                            SettingNameView()
                        case .settingUserID:
                            SettingUserIDView()
                        case .settingWakuUpTime:
                            SettingWakeUpTimeView()
                        case .settingDayOfWeek:
                            SettingDayOfWeekView()
                        case .friendSearch:
                            FriendSearchView()
                        case .friendApproval:
                            FriendApprovalView()
                        }
                    }
            }
            .environmentObject(router)
            .environmentObject(service)
        }
    }
}
