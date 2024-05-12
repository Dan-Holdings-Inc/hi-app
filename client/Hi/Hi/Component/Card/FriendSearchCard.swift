//
//  FriendSearchCard.swift
//  Hi
//
//  Created by Yuma on 2024/04/28.
//

import SwiftUI

struct FriendSearchCard: View {
    @State var isFollowing: Bool = false
    
    var name: String
    var userName: String
    var followAction: () -> Void
    
    var body: some View {
        let screenWidth = UIScreen.main.bounds.width
        
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 5)
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.gray.opacity(0.3), lineWidth: 2)
                        .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 5)
                )
            
            HStack {
                VStack {
                    Text(name)
                        .font(.title2)
                        .bold()
                    Text(userName)
                        .font(.callout)
                }
                .padding(.leading)
                
                Spacer()
                
                Button {
                    isFollowing.toggle()
                    followAction()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(isFollowing ? .gray : .blue)
                            .frame(width: 120, height: 40)
                        Text(isFollowing ? "Following" : "Follow")
                            .foregroundColor(isFollowing ? .black : .white)
                            .bold()
                    }
                }
                .padding(.trailing)
            }
        }
        .frame(width: screenWidth * 0.9, height: 80)
    }
}

#Preview {
    FriendSearchCard(name: "さんぷるくん", userName: "samplekunnnoid", followAction: {
        print("フォローした！")
    })
}
