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
                Text("Find Friends")
                    .font(.title)
                    .bold()
                    .padding()
            }
            // 検索窓
            HStack {
                HStack {
                    TextField("Enter name, user ID, and email address", text: $inputText)
                        .focused($isFocused)
                        .toolbar {
                            ToolbarItemGroup(placement: .keyboard) {
                                Spacer()
                                Button("close") {
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
            .padding()
            
            ScrollView(showsIndicators: false) {
                ForEach(0 ..< viewModel.userList.count, id: \.self) { index in
                    FriendSearchCard(name: viewModel.userList[index].name, userName: viewModel.userList[index].userName, followAction: {
                        viewModel.followFriend(friendId: viewModel.userList[index]._id)
                    })
                }
                .padding()
            }
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
