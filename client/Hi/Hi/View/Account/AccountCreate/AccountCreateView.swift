//
//  AccountCreateView.swift
//  Hi
//
//  Created by Yuma on 2024/04/11.
//

import SwiftUI

struct AccountCreateNameView: View {
    @EnvironmentObject var router: NavigationRouter
    
    var body: some View {
        AccountSettingName(viewModel: AccountCommonNameViewModel(), nextButtonLabel: "次へ", isShowBackButton: false, routerAction: {
            router.navigateToView(destination: .accountCreateUserID)
        })
        .navigationBarHidden(true)
    }
}

struct AccountCreateUserID: View {
    @EnvironmentObject var router: NavigationRouter
    
    var body: some View {
        AccountSettingUserID(nextButtonLabel: "次へ", action: {
            router.navigateToView(destination: .accountCreateWakeUpTime)
        })
        .navigationBarHidden(true)
    }
}

struct AccountCreateWakeUpTimeView: View {
    @EnvironmentObject var router: NavigationRouter
    
    var body: some View {
        AccountSettingWakeUpTime(nextButtonLabel: "次へ", action: {
            router.navigateToView(destination: .accountCreateDayOfWeek)
        })
        .navigationBarHidden(true)
    }
}

struct AccountCreateDayOfWeekView: View {
    @EnvironmentObject var router: NavigationRouter
    @ObservedObject var viewModel: AccountCreateViewModel
    
    var body: some View {
        AccountSettingDayOfWeek(nextButtonLabel: "Hiを始める！", action: {
            viewModel.postNewUserData()
            router.navigateToView(destination: .main)
        })
        .navigationBarHidden(true)
    }
}

#Preview {
    AccountCreateNameView()
}
