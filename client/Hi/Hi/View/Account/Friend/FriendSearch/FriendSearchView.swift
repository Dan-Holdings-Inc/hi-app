//
//  FriendSearchView.swift
//  Hi
//
//  Created by Yuma on 2024/04/12.
//

import SwiftUI

struct FriendSearchView: View {
    @ObservedObject var viewModel: FriendSearchViewModel
    @FocusState private var isFocused: Bool
    @State var inputText = ""
    
    var body: some View {
        VStack {
            ZStack {
                BackButton()
                Text("フレンド検索")
                    .font(.title)
                    .bold()
                    .padding()
            }
            // 検索窓
            HStack {
                HStack {
                    TextField("名前、ユーザーID、メールアドレスを入力", text: $inputText)
                        .focused($isFocused)
                        .toolbar {
                            ToolbarItemGroup(placement: .keyboard) {
                                Spacer()
                                Button("閉じる") {
                                    isFocused = false
                                }
                            }
                        }
                    if isFocused {
                        Button(action: {
                            self.inputText = ""
                        }){
                            Image(systemName: "multiply.circle.fill")
                                .foregroundColor(.gray)
                        }
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(25)
                .overlay(
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(.primary, lineWidth: 1)
                )
            }
            .padding(.horizontal)
            
            ForEach(0 ..< viewModel.userList.count, id: \.self) { index in
                FriendSearchCard(name: viewModel.userList[index].name, userName: viewModel.userList[index].userName, followAction: {
                    viewModel.followFriend(friendId: viewModel.userList[index]._id)
                })
            }
            .padding()
            
            Spacer()
        }
        .onAppear {
            isFocused = true
        }
        .onChange(of: inputText, {
            viewModel.getUserList(searchWord: inputText)
        })
        .navigationBarHidden(true)
    }
}

#Preview {
    FriendSearchView(viewModel: FriendSearchViewModel())
}
