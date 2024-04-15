//
//  UserCard.swift
//  Hi
//
//  Created by Yuma on 2024/04/09.
//

import SwiftUI

struct UserCard: View {
    var userName: String
    var color: Color
    var action: () -> Void
    
    var body: some View {
        let screenWidth = UIScreen.main.bounds.width
        
        Button(action: action) {
            Text("\(userName)")
                .foregroundColor(.white)
                .font(.title)
                .bold()
                .padding()
            
                .frame(width: screenWidth, height: 80)
                .background(color)
        }
    }
}

#Preview {
    UserCard(userName: "だん", color: .blue, action: {
        print("pressed!")
    })
}
