//
//  AccountCreateNameView.swift
//  Hi
//
//  Created by Yuma on 2024/04/10.
//

import SwiftUI

struct AccountCreateNameView: View {
    @EnvironmentObject var router: NavigationRouter
    
    var body: some View {
        AccountSettingName(nextButtonLabel: "次へ", action: {
            router.navigateToView(destination: .accountCreateUserID)
        })
        .navigationBarHidden(true)
    }
}

#Preview {
    AccountCreateNameView()
}
