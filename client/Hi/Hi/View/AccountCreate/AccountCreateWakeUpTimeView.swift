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
            print("次へ")
        })
        .navigationBarHidden(true)
    }
}

#Preview {
    AccountCreateWakeUpTimeView()
}
