//
//  HiApp.swift
//  Hi
//
//  Created by Yuma on 2024/04/08.
//

import SwiftUI

@main
struct HiApp: App {
    @UIApplicationDelegateAdaptor (AppDelegate.self) var appDelegate
    @StateObject var router = NavigationRouter()
    @StateObject var service: Auth0Service = Auth0Service()
    @StateObject var userEnvironmentData = UserEnvironmentData(user: UserWithRelatedData(_id: "", email: "", userName: "", name: "", getUpAt: "", daysToAlarm: [], followers: [], followings: []))
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.navigationPath) {
                ContentView()
                    .navigationDestination(for: NavigationRouter.Path.self) { value in
                        switch value {
                        case .main:
                            TabBar()
                        case .login:
                            LoginView(viewModel: LoginViewModel())
                        case .accountCreateName:
                            AccountCreateNameView()
                        case .accountCreateUserID:
                            AccountCreateUserID()
                        case .accountCreateWakeUpTime:
                            AccountCreateWakeUpTimeView()
                        case .accountCreateDayOfWeek:
                            AccountCreateDayOfWeekView(viewModel: AccountCreateViewModel())
                        case .settingName:
                            SettingNameView(viewModel: SettingViewModel())
                        case .settingUserID:
                            SettingUserIDView(viewModel: SettingViewModel())
                        case .settingWakuUpTime:
                            SettingWakeUpTimeView(viewModel: TimeSettingViewModel())
                        case .settingDayOfWeek:
                            SettingDayOfWeekView(viewModel: TimeSettingViewModel())
                        case .friendSearch:
                            FriendSearchView(viewModel: FriendSearchViewModel())
                        case .friendApproval:
                            FriendApprovalView()
                        }
                    }
            }
            .environmentObject(router)
            .environmentObject(service)
            .environmentObject(userEnvironmentData)
        }
    }
}
