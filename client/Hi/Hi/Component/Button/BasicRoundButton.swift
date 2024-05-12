//
//  LoginButton.swift
//  Hi
//
//  Created by Yuma on 2024/04/09.
//

import SwiftUI

struct BasicRoundButton: View {
    @Environment(\.colorScheme) var colorScheme
    
    var text: Text
    var action: () -> Void
    
    var body: some View {
        let screenWidth = UIScreen.main.bounds.width
        
        Button(action: action) {
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .frame(width: screenWidth * 0.7, height: 50)
                    .foregroundColor(.primary)
                text
                    .foregroundColor(colorScheme == .light ? .white : .black)
                    .bold()
            }
        }
    }
}

#Preview {
    BasicRoundButton(text: Text("テキスト"), action: {
        print("ログイン！")
    })
}
