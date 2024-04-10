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
        // 次ページとのUIの辻褄合わせで苦肉の策
        // 本来はボタンでログイン画面に戻る実装にしたい
        HStack {
            BackButton()
                .padding(.horizontal)
                .padding(.bottom, 5)
            Spacer()
        }
        .opacity(0)
        
        AccountSettingName(nextButtonLabel: "次へ", action: {
            router.navigateToView(destination: .accountCreateUserID)
        })
        .navigationBarHidden(true)
    }
}

#Preview {
    AccountCreateNameView()
}
