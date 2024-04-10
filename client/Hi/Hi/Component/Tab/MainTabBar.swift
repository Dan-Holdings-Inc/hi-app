//
//  TabView.swift
//  Hi
//
//  Created by Yuma on 2024/04/09.
//

import SwiftUI

struct MainTabBar: View {
    @State var selection = 1
    
    var body: some View {
        TabView(selection: $selection) {
            HomeView(viewModel: HomeViewModel())
                .tabItem() {
                    Label("ホーム", systemImage: "house")
                }
                .tag(1)
            SettingView()
                .tabItem() {
                    Label("設定", systemImage: "gearshape")
                }
                .tag(2)
        }
    }
}

#Preview {
    MainTabBar()
}
