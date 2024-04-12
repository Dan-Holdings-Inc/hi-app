//
//  AccountCreateUserID.swift
//  Hi
//
//  Created by Yuma on 2024/04/10.
//

import SwiftUI

struct AccountCreateUserID: View {
    @EnvironmentObject var router: NavigationRouter
    
    var body: some View {
        AccountSettingUserID(nextButtonLabel: "次へ", action: {
            router.navigateToView(destination: .accountCreateWakeUpTime)
        })
        .navigationBarHidden(true)
    }
}

#Preview {
    AccountCreateUserID()
}
