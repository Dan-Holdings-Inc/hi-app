//
//  AccountCreateCommonView.swift
//  Hi
//
//  Created by Yuma on 2024/04/10.
//

import SwiftUI

struct AccountSettingUserID: View {
    @ObservedObject var viewModel = AccountCommonUserIDViewModel()
    @Environment(\.colorScheme) var colorScheme
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
                VStack(alignment: .leading){
                    Text("ユーザーIDはフレンドの検索に使用されます。")
                    Text("他人と同じIDを使うことはできません。")
                    Text("ユーザーIDを入力してください。")
                        .foregroundColor(.red)
                        .opacity(viewModel.isShowEmptyErrorMessage ? 1.0 : 0.0)
                }
                .padding(.horizontal)
                Spacer()
            }
            
            let strokeColor: Color = colorScheme == .light ? .black : .white
            HStack {
                // 英数字のみのキーボードを無理やり作っているが要見直し
                TextField("ユーザーID", text: $viewModel.userID)
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
                    .onChange(of: viewModel.userID) {
                        viewModel.filter()
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
            BasicRoundButton(text: "\(nextButtonLabel)", action: {
                viewModel.showErrorMessage(routerAction: action)
            })
            Spacer()
        }
        .onAppear {
            isFocused = true
        }
    }
}

#Preview {
    AccountSettingUserID(nextButtonLabel: "次へ", action: {
        print("名前の設定完了")
    })
}
