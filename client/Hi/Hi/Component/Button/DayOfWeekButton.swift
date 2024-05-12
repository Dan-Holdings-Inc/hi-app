//
//  DayOfWeekCard.swift
//  Hi
//
//  Created by Yuma on 2024/04/11.
//

import SwiftUI

struct DayOfWeekButton: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.locale) var locale
    
    var label: Text
    var isSelected: Bool
    var action: () -> Void
    
    var body: some View {
        let screenWidth = UIScreen.main.bounds.width
        
        Button(action: {
            action()
        }) {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(colorScheme == .light ? .white : .black)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(colorScheme == .light ? .black : .white, lineWidth: 3)
                            .opacity(isSelected ? 1.0 : 0.3)
                    )
                label
                    .foregroundColor(.primary)
                    .font(.title)
                    .bold()
                    .opacity(isSelected ? 1.0 : 0.2)
            }
            .frame(width: screenWidth / (locale.language.languageCode?.identifier ?? "" == "ja" ? 9 : 4), height: 50)
        }
    }
}

#Preview {
    DayOfWeekButton(label: Text("Mon"), isSelected: false, action: {
        print("タップ！")
    })
}
