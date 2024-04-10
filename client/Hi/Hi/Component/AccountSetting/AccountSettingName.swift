//
//  AccountCreateCommonView.swift
//  Hi
//
//  Created by Yuma on 2024/04/10.
//

import SwiftUI

struct AccountSettingName: View {
    @State var displayName = ""
    @FocusState private var isFocused: Bool
    
    var nextButtonLabel: String
    var action: () -> Void
    
    var body: some View {
        VStack {
            HStack {
                Text("名前を入力してください")
                    .font(.title)
                    .bold()
                    .padding(.horizontal)
                    .padding(.bottom, 5)
                Spacer()
            }
            HStack {
                Text("名前はフレンドに表示されます。")
                    .padding(.horizontal)
                Spacer()
            }
            TextField("名前", text: $displayName)
                .focused($isFocused)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(15)
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(isFocused ? .black : .gray, lineWidth: 1)
                )
                .padding()
            BasicRoundButton(text: "\(nextButtonLabel)", action: action)
            Spacer()
        }
        .onAppear {
            isFocused = true
        }
    }
}

#Preview {
    AccountSettingName(nextButtonLabel: "次へ", action: {
        print("名前の設定完了")
    })
}
