//
//  AccountCommonViewModel.swift
//  Hi
//
//  Created by Yuma on 2024/04/18.
//

import Foundation
import SwiftUI

let userDefaultsHelper = UserDefaultsHelper()

class AccountCommonNameViewModel: ObservableObject {
    @Published var name = userDefaultsHelper.getStringData(key: "name")
    @Published var isShowErrorMessage = false
    
    func showErrorMessage(routerAction: () -> Void) {
        if name.isEmpty {
            withAnimation {
                isShowErrorMessage = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    self.isShowErrorMessage = false
                }
            }
        } else {
            userDefaultsHelper.set(value: name, key: "name")
            routerAction()
        }
    }
}

class AccountCommonUserIDViewModel: ObservableObject {
    @Published var userID = userDefaultsHelper.getStringData(key: "userID")
    @Published var isShowEmptyErrorMessage = false
    
    func showErrorMessage(routerAction: () -> Void) {
        if userID.isEmpty {
            withAnimation {
                isShowEmptyErrorMessage = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    self.isShowEmptyErrorMessage = false
                }
            }
        } else {
            userDefaultsHelper.set(value: userID, key: "userID")
            routerAction()
        }
    }
    
    func filter() {
        let validCodes = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
        let sets = CharacterSet(charactersIn: validCodes)
        userID = String(userID.unicodeScalars.filter(sets.contains).map(Character.init))
    }
}

class AccountCommonDayOfWeekViewModel: ObservableObject {
    @Published var dayOfWeekSelected = Array(repeating: false, count: 7)
    
    func nextButtonAction() {
        userDefaultsHelper.set(value: dayOfWeekSelected, key: "dayOfWeekSelected")
    }
    
    func onAppear() {
        dayOfWeekSelected = userDefaultsHelper.getArrayData(key: "dayOfWeekSelected") as? [Bool] ?? []
    }
}
