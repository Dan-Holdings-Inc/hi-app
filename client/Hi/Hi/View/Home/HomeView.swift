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
    
    var body: some View {
        VStack {
            HStack{
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                TextField("検索", text: $searchText)
            }
            .padding()
            .background(Color(.systemGray5))
            .cornerRadius(15)
            .padding(.horizontal)
            List {
                if userEnvironmentData.user.followings.count == 0 {
                    UserCard(userName: "Tiffany", color: .gray, action: {
                        print("Hi!")
                    })
                }
                ForEach(0 ..< userEnvironmentData.user.followings.count, id: \.self) { index in
                    UserCard(userName: userEnvironmentData.user.followings[index].name, color: viewModel.cardColors[index % viewModel.cardColors.count], action: {
                        viewModel.userCardButtonAction(name: userEnvironmentData.user.followings[index].name)
                    })
                    .swipeActions(edge: .trailing){
                        Button("削除", role: .destructive) {
                        }
                    }
                    .listRowInsets(EdgeInsets())
                }
            }
            .listStyle(GroupedListStyle())
        }
    }
}

#Preview {
    HomeView(viewModel: HomeViewModel())
}
