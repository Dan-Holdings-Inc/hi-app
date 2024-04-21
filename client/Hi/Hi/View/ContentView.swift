//
//  ContentView.swift
//  Hi
//
//  Created by Yuma on 2024/04/08.
//

import SwiftUI

struct ContentView: View {
    var body: some View {

//        if service.isAuthenticated {
//            AccountCreateNameView()
//        } else {
        LoginView(viewModel: LoginViewModel())
//        }

    }
}

#Preview {
    ContentView()
}
