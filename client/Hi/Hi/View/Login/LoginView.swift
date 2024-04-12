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
    @State var mailAdress = ""
    @State var password = ""
    
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