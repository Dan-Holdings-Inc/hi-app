//
//  AccountCreateDayOfWeekView.swift
//  Hi
//
//  Created by Yuma on 2024/04/11.
//

import SwiftUI

struct AccountCreateDayOfWeekView: View {
    @EnvironmentObject var router: NavigationRouter
    
    var body: some View {
        AccountSettingDayOfWeek(nextButtonLabel: "Hiを始める！", action: {
            router.navigateToView(destination: .main)
        })
        .navigationBarHidden(true)
    }
}

#Preview {
    AccountCreateDayOfWeekView()
}
