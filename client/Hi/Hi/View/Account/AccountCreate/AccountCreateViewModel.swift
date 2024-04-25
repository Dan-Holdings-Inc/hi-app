//
//  AccountCreateViewModel.swift
//  Hi
//
//  Created by Yuma on 2024/04/21.
//

import Foundation
import Combine

class AccountCreateViewModel: ObservableObject {
    let userDefaultsHelper = UserDefaultsHelper()
    private var cancellables: Set<AnyCancellable> = []
    
    func postNewUserData() {
        let newUser = setNewUserData()
        print(newUser)
        AccountCreateModel.postUserData(userRegistrationDto: newUser)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("成功した")
                    break
                case .failure(let error):
                    print(error.errorDescription)
                }
            }, receiveValue: { data in
                print(data)
            })
            .store(in: &cancellables)
    }
    
    func setNewUserData() -> UserRegistrationDto {
        let uuid = UUID().uuidString
        let email = userDefaultsHelper.getStringData(key: "email")
        let name = userDefaultsHelper.getStringData(key: "name")
        let userName = userDefaultsHelper.getStringData(key: "userName")
        let getUpAt = userDefaultsHelper.getStringData(key: "wakeUpTime")
        let daysToAlarm = userDefaultsHelper.getArrayData(key: "dayOfWeekSelected") as? [Bool] ?? []
        let deviceToken = userDefaultsHelper.getStringData(key: "deviceToken")
        
        let newUserData = UserRegistrationDto(_id: uuid, email: email, userName: userName,
                                              name: name, getUpAt: getUpAt, daysToAlarm: daysToAlarm, deviceToken: deviceToken)
        
        return newUserData
    }
}
