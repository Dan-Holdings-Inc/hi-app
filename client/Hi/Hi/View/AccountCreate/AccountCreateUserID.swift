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
        HStack {
            BackButton()
                .padding(.horizontal)
                .padding(.bottom, 5)
            Spacer()
        }
        AccountSettingUserID(nextButtonLabel: "次へ", action: {
            print("次へ")
        })
        .navigationBarHidden(true)
    }
}

#Preview {
    AccountCreateUserID()
}
