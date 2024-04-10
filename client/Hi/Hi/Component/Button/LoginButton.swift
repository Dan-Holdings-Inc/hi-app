//
//  LoginButton.swift
//  Hi
//
//  Created by Yuma on 2024/04/09.
//

import SwiftUI

struct LoginButton: View {
    var action: () -> Void
    
    var body: some View {
        let screenWidth = UIScreen.main.bounds.width
        
        Button(action: action) {
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .frame(width: screenWidth * 0.7, height: 50)
                    .foregroundColor(.black)
                Text("ログイン")
                    .foregroundColor(.white)
                    .bold()
            }
        }
    }
}

#Preview {
    LoginButton(action: {
        print("ログイン！")
    })
}
