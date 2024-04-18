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
    
    func showEmptyErrorMessage(routerAction: () -> Void) {
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
