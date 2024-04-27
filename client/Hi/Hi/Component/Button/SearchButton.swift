//
//  SearchButton.swift
//  Hi
//
//  Created by ryosei on 2024/04/27.
//

import SwiftUI

struct SearchButton: View {
    var action: () -> Void
    
    var body: some View {
        
        Button(action: {
            action()
        }){
            ZStack{
                Image(systemName: "magnifyingglass")
                    .bold()
                    .padding()
                    .frame(width: 50, height: 50)
                    .foregroundColor(Color.gray)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 3)
                    )
            }
        }
    }
}

#Preview {
    SearchButton {
        print("検索します")
    }
}
