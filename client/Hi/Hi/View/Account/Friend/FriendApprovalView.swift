//
//  FriendApprovalView.swift
//  Hi
//
//  Created by Yuma on 2024/04/12.
//

import SwiftUI

struct FriendApprovalView: View {
    var body: some View {
        VStack {
            ZStack {
                BackButton()
                Text("Friend approval")
                    .font(.title)
                    .bold()
                    .padding()
            }
            
            Spacer()
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    FriendApprovalView()
}
