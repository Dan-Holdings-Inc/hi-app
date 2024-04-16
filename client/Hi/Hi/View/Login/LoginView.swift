//
//  LoginView.swift
//  Hi
//
//  Created by Yuma on 2024/04/09.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var router: NavigationRouter
    @EnvironmentObject var service: Auth0Service
    
    var body: some View {
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
            
            BasicRoundButton(text: "始める", action: {
                service.login()
            })
            
            Button {
                router.navigateToView(destination: .accountCreateName)
            } label: {
                Text("名前入力画面へ（開発用）")
                    .padding()
            }
            Button {
                router.navigateToView(destination: .main)
            } label: {
                Text("メイン画面へ（開発用）")
                    .padding()
            }
            
            Spacer()
        }
        .navigationBarHidden(true)
        .onChange(of: service.isAuthenticated) {
            if service.isAuthenticated {
                router.navigateToView(destination: .accountCreateName)
            }
        }
    }
}

#Preview {
    LoginView()
}
