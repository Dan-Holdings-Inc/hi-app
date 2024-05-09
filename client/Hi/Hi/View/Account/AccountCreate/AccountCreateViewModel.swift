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
        let email = userDefaultsHelper.getStringData(key: UserDefaultsKey.email)
        let name = userDefaultsHelper.getStringData(key: UserDefaultsKey.name)
        let userName = userDefaultsHelper.getStringData(key: UserDefaultsKey.userName)
        let getUpAt = userDefaultsHelper.getStringData(key: UserDefaultsKey.getUpAt)
        let daysToAlarm = userDefaultsHelper.getArrayData(key: UserDefaultsKey.dayToAlarm) as? [Bool] ?? []
        let deviceToken = userDefaultsHelper.getStringData(key: UserDefaultsKey.deviceToken)
        
        let newUserData = UserRegistrationDto(_id: uuid, email: email, userName: userName,
                                              name: name, getUpAt: getUpAt, daysToAlarm: daysToAlarm, deviceToken: deviceToken)
        
        return newUserData
    }
}
