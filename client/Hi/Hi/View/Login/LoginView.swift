//
//  LoginView.swift
//  Hi
//
//  Created by Yuma on 2024/04/09.
//

import SwiftUI

struct LoginView: View {
    @State var mailAdress = ""
    @State var password = ""
    
    var body: some View {
        let screenWidth = UIScreen.main.bounds.width
        
        VStack {
            Spacer()
            HStack {
                Text("Hi!")
                    .font(.largeTitle)
                    .bold()
                    .shadow(radius: 10)
                Image(systemName: "hand.wave")
                    .resizable()
                    .frame(width: 30, height: 30)
            }
            Spacer()
            TextField("メールアドレス", text: $mailAdress)
                .padding()
                .multilineTextAlignment(.center)
                .frame(width: screenWidth * 0.9)
                .background(Color(.systemGray6))
                .cornerRadius(25)
                .shadow(radius: 10)
                .padding()
            TextField("パスワード", text: $password)
                .padding()
                .multilineTextAlignment(.center)
                .frame(width: screenWidth * 0.9)
                .background(Color(.systemGray6))
                .cornerRadius(25)
                .shadow(radius: 10)
                .padding(.horizontal)
            LoginButton(action: {
                print("ログインする！")
            })
            .padding()
            Button {
                print("アカウント")
            } label: {
                Text("アカウントの新規作成 ＞")
            }
            Spacer()
        }
    }
}

#Preview {
    LoginView()
}
