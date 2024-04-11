//
//  SettingCard.swift
//  Hi
//
//  Created by Yuma on 2024/04/11.
//

import SwiftUI

struct SettingCard: View {
    var label: String
    var action: () -> Void
    
    var body: some View {
        let screenWidth = UIScreen.main.bounds.width
        
        Button(action: action) {
            ZStack {
                let cornerRadius = 10.0
                RoundedRectangle(cornerRadius: cornerRadius)
                    .foregroundColor(.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .stroke(.black, lineWidth: 1)
                    )
                HStack {
                    Text("\(label)")
                        .foregroundColor(.black)
                        .font(.title2)
                        .bold()
                    Spacer()
                    Image(systemName: "chevron.forward")
                        .foregroundColor(.gray)
                }
                .padding(.horizontal)
            }
            .frame(width: screenWidth * 0.9, height: 50)
            .shadow(radius: 5)
        }
        .padding(.bottom)
    }
}

#Preview {
    SettingCard(label: "名前", action: {
        print("設定へ！")
    })
}
