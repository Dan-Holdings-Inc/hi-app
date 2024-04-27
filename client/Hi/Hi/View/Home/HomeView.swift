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
    
    var body: some View {
        VStack {
            HStack{
                HStack{
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
                            if searchText.isEmpty{
                                print("入力なし")
                            }else{
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
                        }){
                            Image(systemName: "multiply.circle.fill")
                                .foregroundColor(.gray)
                        }
                    }
                }
                .padding()
                .background(Color(.systemGray5))
                .cornerRadius(15)
                .padding(.leading)
                SearchButton(action: {
                    if searchText.isEmpty{
                        print("入力なし")
                    }else{
                        print("\(searchText)")
                        let isFollowing = userEnvironmentData.user.followings.contains { user in
                            user.name == searchText
                        }
                        print(isFollowing)
                    }
                })
                .padding(.trailing)
            }
            
            if userEnvironmentData.user.followings.isEmpty {
                VStack {
                    Text("フレンドがいません。\"**アカウント < フレンド検索**\"からフレンドを追加してください。")
                }
                .padding()
            }
            List {
                let cardColors = Colors.cardColors
                ForEach(0 ..< userEnvironmentData.user.followings.count, id: \.self) { index in
                    UserCard(userName: userEnvironmentData.user.followings[index].name, color: cardColors[index % cardColors.count], action: {
                        viewModel.userCardButtonAction(name: userEnvironmentData.user.followings[index].name)
                        viewModel.postHi(friendId: userEnvironmentData.user.followings[index]._id)
                    })
                    .swipeActions(edge: .trailing){
                        Button("削除", role: .destructive) {
                        }
                    }
                    .listRowInsets(EdgeInsets())
                }
            }
            .listStyle(GroupedListStyle())
            .scrollContentBackground(.hidden)
            .background(.white)
        }
    }
}

#Preview {
    HomeView(viewModel: HomeViewModel())
}
