//
//  UserCard.swift
//  Hi
//
//  Created by Yuma on 2024/04/09.
//

import SwiftUI

struct UserCardButton: View {
    var userName: String
    var color: Color
    var action: () -> Void
    
    var body: some View {
        let screenWidth = UIScreen.main.bounds.width
        
        Button(action: action) {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(color)
                Text("\(userName)")
                    .foregroundColor(.white)
                    .font(.title)
                    .bold()
            }
            .frame(width: screenWidth * 0.9, height: 80)
            .shadow(color: Color.gray.opacity(0.6), radius: 4, x: 10, y: 10)
        }
        .padding(.bottom)
    }
}

#Preview {
    UserCardButton(userName: "だん", color: .blue, action: {
        print("pressed!")
    })
}
