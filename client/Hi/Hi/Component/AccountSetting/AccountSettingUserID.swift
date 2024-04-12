//
//  AccountCreateCommonView.swift
//  Hi
//
//  Created by Yuma on 2024/04/10.
//

import SwiftUI

struct AccountSettingUserID: View {
    @Environment(\.colorScheme) var colorScheme
    @State var userID = ""
    @FocusState private var isFocused: Bool
    
    var nextButtonLabel: String
    var action: () -> Void
    
    var body: some View {
        VStack {
            BackButton()
                .padding(.bottom, 5)
            HStack {
                Text("ユーザーIDを設定")
                    .font(.title)
                    .bold()
                    .padding(.horizontal)
                    .padding(.bottom, 5)
                Spacer()
            }
            HStack {
                Text("ユーザーIDはフレンドの検索に使用されます。")
                    .padding(.horizontal)
                Spacer()
            }
            HStack {
                Text("他人と同じIDを使うことはできません。")
                    .padding(.horizontal)
                Spacer()
            }
            
            let strokeColor: Color = colorScheme == .light ? .black : .white
            HStack {
                // 英数字のみのキーボードを無理やり作っているが要見直し
                TextField("ユーザーID", text: $userID)
                    .focused($isFocused)
                    .toolbar {
                        ToolbarItemGroup(placement: .keyboard) {
                            Spacer()
                            Button("閉じる") {
                                isFocused = false
                            }
                        }
                    }
                    .keyboardType(.asciiCapable)
                    .onChange(of: userID) {
                        filter(value: userID)
                    }
                Image(systemName: "checkmark.circle")
                    .foregroundColor(.green)
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(15)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(isFocused ? strokeColor : .gray, lineWidth: 1)
            )
            .padding()
            BasicRoundButton(text: "\(nextButtonLabel)", action: action)
            Spacer()
        }
        .onAppear {
            isFocused = true
        }
    }
    
    func filter(value: String) {
        let validCodes = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
        let sets = CharacterSet(charactersIn: validCodes)
        userID = String(value.unicodeScalars.filter(sets.contains).map(Character.init))
    }
}

#Preview {
    AccountSettingUserID(nextButtonLabel: "次へ", action: {
        print("名前の設定完了")
    })
}
