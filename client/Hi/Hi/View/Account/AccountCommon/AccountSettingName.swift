//
//  AccountCreateCommonView.swift
//  Hi
//
//  Created by Yuma on 2024/04/10.
//

import SwiftUI

struct AccountSettingName: View {
    @Environment(\.colorScheme) var colorScheme
    @FocusState private var isFocused: Bool
    @State var name = UserDefaultsHelper().getStringData(key: "name")
    @State var isShowErrorMessage = false
    
    var nextButtonLabel: String
    var isShowBackButton: Bool
    var action: () -> Void
    
    var body: some View {
        VStack {
            BackButton()
                .padding(.bottom, 5)
                .opacity(isShowBackButton ? 1.0 : 0.0)
            
            HStack {
                Text("名前を入力してください")
                    .font(.title)
                    .bold()
                    .padding(.horizontal)
                    .padding(.bottom, 5)
                Spacer()
            }
            HStack {
                VStack(alignment: .leading) {
                    Text("名前はフレンドに表示されます。")
                    Text("名前を入力してください。")
                        .foregroundColor(.red)
                        .opacity(isShowErrorMessage ? 1.0 : 0.0)
                }
                .padding(.horizontal)
                Spacer()
            }
            
            let strokeColor: Color = colorScheme == .light ? .black : .white
            TextField("名前", text: $name)
                .focused($isFocused)
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        Button("閉じる") {
                            isFocused = false
                        }
                    }
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
                if name.isEmpty {
                    withAnimation {
                        isShowErrorMessage = true
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation {
                            isShowErrorMessage = false
                        }
                    }
                } else {
                    UserDefaultsHelper().set(value: name, key: "name")
                    action()
                }
            })
            Spacer()
        }
        .onAppear {
            isFocused = true
        }
    }
}

#Preview {
    AccountSettingName(nextButtonLabel: "次へ", isShowBackButton: false, action: {
        print("名前の設定完了")
    })
}
