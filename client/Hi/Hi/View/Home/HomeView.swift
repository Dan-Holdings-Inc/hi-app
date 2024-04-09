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
        ScrollView {
            ForEach(0 ..< 10) { index in
                UserCardButton(userName: "\(index)番目の人", color: viewModel.cardColors[index % viewModel.cardColors.count], action: {
                    viewModel.userCardButtonAction(index: index)
                })
            }
            .frame(maxWidth: .infinity)
        }
    }
}

#Preview {
    HomeView(viewModel: HomeViewModel())
}
