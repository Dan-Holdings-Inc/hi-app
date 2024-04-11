//
//  AccountCreateWakeUpTimeView.swift
//  Hi
//
//  Created by Yuma on 2024/04/11.
//

import SwiftUI

struct AccountCreateWakeUpTimeView: View {
    @EnvironmentObject var router: NavigationRouter
    
    var body: some View {
        AccountSettingWakeUpTime(nextButtonLabel: "次へ", action: {
            router.navigateToView(destination: .accountCreateDayOfWeek)
        })
        .navigationBarHidden(true)
    }
}

#Preview {
    AccountCreateWakeUpTimeView()
}
