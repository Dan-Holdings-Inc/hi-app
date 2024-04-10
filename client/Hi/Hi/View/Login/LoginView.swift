//
//  LoginView.swift
//  Hi
//
//  Created by Yuma on 2024/04/09.
//

import SwiftUI

struct LoginView: View {
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
            
            LoginButton(action: {
                service.login()
            })
            Spacer()
        }
    }
}

#Preview {
    LoginView()
}
