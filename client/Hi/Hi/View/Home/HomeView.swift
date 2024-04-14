//
//  HomeView.swift
//  Hi
//
//  Created by Yuma on 2024/04/09.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        List {
            ForEach(0 ..< 10) { index in
                UserCard(userName: "\(index)番目の人", color: viewModel.cardColors[index % viewModel.cardColors.count], action: {
                    viewModel.userCardButtonAction(index: index)
                })
                .swipeActions(edge: .trailing){
                    Button("削除", role: .destructive) {
                    }
                }
            }
            .frame(maxWidth: .infinity)
        }
    }
}

#Preview {
    HomeView(viewModel: HomeViewModel())
}
