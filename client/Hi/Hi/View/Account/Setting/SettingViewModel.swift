//
//  SettingViewModel.swift
//  Hi
//
//  Created by Yuma on 2024/04/19.
//

import Foundation

class SettingViewModel: ObservableObject {
    @Published var name = ""
    @Published var userID = ""
    
    let userDefaultsHelper = UserDefaultsHelper()
    
    func onAppear() {
        name = userDefaultsHelper.getStringData(key: "name")
        userID = userDefaultsHelper.getStringData(key: "userID")
    }
}
