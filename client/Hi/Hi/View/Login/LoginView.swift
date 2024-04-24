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
    @ObservedObject var viewModel: LoginViewModel
    
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
            
            Text("エラーが発生しました。")
                .foregroundColor(.red)
                .opacity(viewModel.isShowErrorMessage ? 1 : 0)
            
            BasicRoundButton(text: "始める", action: {
                service.login()
                viewModel.startButtonAction()
            })
            Spacer()
        }
        .navigationBarHidden(true)
        .onChange(of: service.isAuthenticated) {
            if service.isAuthenticated {
                viewModel.getUserDataAndNavigateView(successRouteAction: {
                    router.navigateToView(destination: .main)
                }, failRouteAction: {
                    router.navigateToView(destination: .accountCreateName)
                }, otherErrorAction: {
                    service.resetAuthenticated()
                })
            }
        }
    }
}

#Preview {
    LoginView(viewModel: LoginViewModel())
}
