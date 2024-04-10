//
//  HiApp.swift
//  Hi
//
//  Created by Yuma on 2024/04/08.
//

import SwiftUI

@main
struct HiApp: App {
    @StateObject var service: Auth0Service = Auth0Service()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(service)
        }
    }
}
