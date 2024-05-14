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
                TextField("search", text: $searchText)
                    .focused($isFocused)
                    .toolbar {
                        ToolbarItemGroup(placement: .keyboard) {
                            Spacer()
                            Button("close") {
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
                    Text("You have no friends. Please add a friend through \"**Account < Find Friends**\".")
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
                    Button("delete", role: .destructive) {
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
                    title: Text("Do you want to delete a friend?"),
                    primaryButton: .cancel(Text("cancel")),
                    secondaryButton: .destructive(Text("delete"), action: {
                        if let user = userToDelete {
                            print("削除完了")
                            viewModel2.DeleteFriend(friendId: user._id)
                            userEnvironmentData.user.followings.removeAll { $0._id == user._id }
                        }
                    })
                )
            }
        }
        .overlay(alignment: .bottomTrailing) {
            FloatingButton {
                FloatingAction(symbol: "eraser") {
                    print("tap1")
                }
                FloatingAction(symbol: "pencil.line") {
                    print("tap2")
                }
                FloatingAction(symbol: "scribble") {
                    print("tap3")
                }
            } label: { isExpanded in
                Image(systemName: "plus")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .rotationEffect(.init(degrees: isExpanded ? 45 : 0))
                    .scaleEffect(1.02)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.black, in: .circle)
                    .scaleEffect(isExpanded ? 0.9 : 1)
            }
            .padding()
        }
    }
}
