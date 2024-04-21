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
    
    func getUserDataAndNavigateView(successRouteAction: @escaping () -> Void, failRouteAction: @escaping () -> Void) {
        let email = userDefaults.getStringData(key: "email")
        
        ApiService.getUserRegistrationDto(email: email)
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
                            withAnimation {
                                self.isShowErrorMessage = true
                            }
                        }
                    }
                    print(error.localizedDescription)
                }
            }, receiveValue: { data in
                print(data)
            })
            .store(in: &cancellables)
    }
}
