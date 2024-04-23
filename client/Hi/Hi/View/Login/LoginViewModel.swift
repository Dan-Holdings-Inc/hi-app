//
//  LoginViewModel.swift
//  Hi
//
//  Created by Yuma on 2024/04/20.
//

import Foundation
import Combine
import SimpleKeychain
import SwiftUI

class LoginViewModel: ObservableObject {
    @Published var isShowErrorMessage = false
    
    let userDefaults = UserDefaultsHelper()
    private var cancellables: Set<AnyCancellable> = []
    
    func getUserDataAndNavigateView(successRouteAction: @escaping () -> Void,
                                    failRouteAction: @escaping () -> Void,
                                    otherErrorAction: @escaping () -> Void) {
        
        let email = userDefaults.getStringData(key: "email")
        
        LoginModel.getUserWithRelationship(email: email)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    DispatchQueue.main.async {
                        successRouteAction()
                    }
                    break
                case .failure(let error):
                    print(error)
                    switch error {
                    case .emptyData:
                        self.userDefaults.removeUserDefaults()
                        DispatchQueue.main.async {
                            failRouteAction()
                        }
                    default:
                        DispatchQueue.main.async {
                            otherErrorAction()
                            withAnimation {
                                self.isShowErrorMessage = true
                            }
                        }
                    }
                    print(error.localizedDescription)
                }
            }, receiveValue: { data in
                self.setUserData(user: data)
                print(data)
            })
            .store(in: &cancellables)
    }
    
    func setUserData(user: UserWithRelatedData) {
        userDefaults.set(value: user.email, key: "email")
        userDefaults.set(value: user.name, key: "name")
        userDefaults.set(value: user.userName, key: "userName")
        userDefaults.set(value: user.getUpAt, key: "wakeUpTime")
        userDefaults.set(value: user.daysToAlarm, key: "dayOfWeekSelected")
    }
}
