//
//  HomeView.swift
//  Hi
//
//  Created by Yuma on 2024/04/09.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var userEnvironmentData: UserEnvironmentData
    @ObservedObject var viewModel: HomeViewModel
    @State private var searchText = ""
    @FocusState private var isFocused: Bool
    @ObservedObject var viewModel2: DeleteViewModel
    @State private var isAlertPresented = false
    @State private var userToDelete: User?
    
    var filteredFollowings: [User] {
        if searchText.isEmpty {
            return userEnvironmentData.user.followings
        } else {
            return userEnvironmentData.user.followings.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                TextField("検索", text: $searchText)
                    .focused($isFocused)
                    .toolbar {
                        ToolbarItemGroup(placement: .keyboard) {
                            Spacer()
                            Button("閉じる") {
                                isFocused = false
                            }
                        }
                    }
                    .onSubmit {
                        if searchText.isEmpty {
                            print("入力なし")
                        } else {
                            print("\(searchText)")
                            let isFollowing = userEnvironmentData.user.followings.contains { user in
                                user.name == searchText
                            }
                            print(isFollowing)
                        }
                    }
                if isFocused {
                    Button(action: {
                        self.searchText = ""
                    }) {
                        Image(systemName: "multiply.circle.fill")
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding()
            .background(Color(.systemGray5))
            .cornerRadius(15)
            .padding(.horizontal)
            
            if userEnvironmentData.user.followings.isEmpty {
                VStack {
                    Text("フレンドがいません。\"**アカウント < フレンド検索**\"からフレンドを追加してください。")
                }
                .padding()
            }
            
            List(filteredFollowings, id: \.self) { user in
                let cardColors = Colors.cardColors
                UserCard(userName: user.name, color: cardColors[userEnvironmentData.user.followings.firstIndex(of: user)! % cardColors.count], action: {
                    viewModel.userCardButtonAction(name: user.name)
                    viewModel.postHi(friendId: user._id)
                })
                .swipeActions(edge: .trailing) {
                    Button("削除", role: .destructive) {
                        userToDelete = user
                        isAlertPresented = true
                    }
                }
                .listRowInsets(EdgeInsets())
            }
            .listStyle(GroupedListStyle())
            .scrollContentBackground(.hidden)
            .background(Color.white)
            .alert(isPresented: $isAlertPresented){
                Alert(
                    title: Text("フレンドを削除しますか？"),
                    primaryButton: .cancel(Text("キャンセル")),
                    secondaryButton: .destructive(Text("削除"), action: {
                        if let user = userToDelete {
                            print("削除完了")
                            viewModel2.DeleteFriend(friendId: user._id)
                            userEnvironmentData.user.followings.removeAll { $0._id == user._id }
                        }
                    })
                )
            }
        }
    }
}
