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
            .padding(.horizontal)
            List {
                if userEnvironmentData.user.followings.count == 0 {
                    UserCard(userName: "Tiffany", color: .gray, action: {
                        viewModel.userCardButtonAction(name: "Tiffany")
                    })
                    .listRowInsets(EdgeInsets())
                }
                ForEach(0 ..< userEnvironmentData.user.followings.count, id: \.self) { index in
                    UserCard(userName: userEnvironmentData.user.followings[index].name, color: viewModel.cardColors[index % viewModel.cardColors.count], action: {
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
