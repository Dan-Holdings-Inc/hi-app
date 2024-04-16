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
    @State private var scale: CGFloat = 1.0
    
    var body: some View {
        let screenWidth = UIScreen.main.bounds.width
        
        Button(action: {
            withAnimation {
                scale = 0.95
                action()
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    withAnimation{
                        scale = 1.0
                    }
                }
            }
        }) {
            Text("\(userName)")
                .foregroundColor(.white)
                .font(.title)
                .bold()
                .padding()
                .frame(width: screenWidth, height: 80)
                .background(color)
                .scaleEffect(scale)
        }
    }
}


#Preview {
    UserCard(userName: "だん", color: .blue, action: {
        print("pressed!")
    })
}
