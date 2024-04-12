//
//  DayOfWeekCard.swift
//  Hi
//
//  Created by Yuma on 2024/04/11.
//

import SwiftUI

struct DayOfWeekButton: View {
    @State var isSelected = false
    
    var label: String
    
    var body: some View {
        let screenWidth = UIScreen.main.bounds.width
        
        Button(action: {
            isSelected.toggle()
        }) {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(.black, lineWidth: 3)
                            .opacity(isSelected ? 1.0 : 0.3)
                    )
                Text("\(label)")
                    .foregroundColor(isSelected ? .black : .gray)
                    .font(.title)
                    .bold()
            }
            .frame(width: screenWidth / 9, height: 50)
        }
    }
}

#Preview {
    DayOfWeekButton(label: "月")
}
