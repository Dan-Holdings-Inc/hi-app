//
//  FriendSummaryView.swift
//  Hi
//
//  Created by Yuma on 2024/04/12.
//

import SwiftUI

struct FriendSummaryView: View {
    @FocusState private var isFocused: Bool
    @State var inputText = ""
    
    var body: some View {
        VStack {
            ZStack {
                BackButton()
                Text("フレンド一覧")
                    .font(.title)
                    .bold()
            }
            .padding()
            // 検索窓
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("名前を入力してみよう", text: $inputText)
                    .focused($isFocused)
                    .toolbar {
                        ToolbarItemGroup(placement: .keyboard) {
                            Spacer()
                            Button("閉じる") {
                                isFocused = false
                            }
                        }
                    }
                if isFocused {
                    Button(action: {
                        self.inputText = ""
                    }){
                        Image(systemName: "multiply.circle.fill")
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(25)
            .padding(.horizontal)
            
            
            Spacer()
        }
    }
}

#Preview {
    FriendSummaryView()
}
