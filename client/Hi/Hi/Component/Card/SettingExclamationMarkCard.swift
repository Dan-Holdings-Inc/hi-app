//
//  SettingExclamationMarkCard.swift
//  Hi
//
//  Created by Yuma on 2024/04/12.
//

import SwiftUI

struct SettingExclamationMarkCard: View {
    var label: String
    var isShowMark: Bool
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
                    Image(systemName: "exclamationmark.circle")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.red)
                        .opacity(isShowMark ? 1.0 : 0.0)
                    Image(systemName: "chevron.forward")
                        .foregroundColor(.gray)
                }
                .padding(.horizontal)
            }
            .frame(width: screenWidth * 0.9, height: 50)
        }
    }
}

#Preview {
    SettingExclamationMarkCard(label: "フレンド承認", isShowMark: true, action: {
        print("フレンド承認画面へ")
    })
}
