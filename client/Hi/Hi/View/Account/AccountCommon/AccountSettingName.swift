//
//  AccountCreateCommonView.swift
//  Hi
//
//  Created by Yuma on 2024/04/10.
//

import SwiftUI

struct AccountSettingName: View {
    @ObservedObject var viewModel: AccountCommonNameViewModel
    @Environment(\.colorScheme) var colorScheme
    @FocusState private var isFocused: Bool
    
    var nextButtonLabel: String
    var isShowBackButton: Bool
    var routerAction: () -> Void
    
    var body: some View {
        VStack {
            BackButton()
                .padding(.bottom, 5)
                .opacity(isShowBackButton ? 1.0 : 0.0)
            
            HStack {
                Text("Enter your name")
                    .font(.title)
                    .bold()
                    .padding(.horizontal)
                    .padding(.bottom, 5)
                Spacer()
            }
            HStack {
                VStack(alignment: .leading) {
                    Text("Names will be displayed to friends.")
                    Text("Name is blank.")
                        .foregroundColor(.red)
                        .opacity(viewModel.isShowErrorMessage ? 1.0 : 0.0)
                }
                .padding(.horizontal)
                Spacer()
            }
            
            let strokeColor: Color = colorScheme == .light ? .black : .white
            TextField("Name", text: $viewModel.name)
                .focused($isFocused)
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        Button("close") {
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
                viewModel.showErrorMessage(routerAction: routerAction)
            })
            Spacer()
        }
        .onAppear {
            isFocused = true
        }
    }
}

#Preview {
    AccountSettingName(viewModel: AccountCommonNameViewModel(), nextButtonLabel: "次へ", isShowBackButton: false, routerAction: {
        print("名前の設定完了")
    })
}
