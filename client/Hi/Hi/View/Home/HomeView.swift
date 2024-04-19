//
//  HomeView.swift
//  Hi
//
//  Created by Yuma on 2024/04/09.
//

import SwiftUI

struct HomeView: View {
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
                ForEach(0 ..< 10) { index in
                    UserCard(userName: "\(index)番目の人", color: viewModel.cardColors[index % viewModel.cardColors.count], action: {
                        viewModel.userCardButtonAction(index: index)
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
