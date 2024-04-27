//
//  TimeSettingViewModel.swift
//  Hi
//
//  Created by ryosei on 2024/04/27.
//

import Foundation
import Combine

class TimeSettingViewModel: ObservableObject {
    @Published var name = ""
    @Published var userID = ""
    
    let userDefaultsHelper = UserDefaultsHelper()
    private var cancellables: Set<AnyCancellable> = []
    
    func onAppear() {
        name = userDefaultsHelper.getStringData(key: "name")
        userID = userDefaultsHelper.getStringData(key: "userName")
    }
    
    func putUserData(){
        let changeTime = setChangeTimeData()
        print(changeTime)
        TimeSettingModel.putUserData(timechangeDto: changeTime, id: changeTime.userId)
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
    
    func setChangeTimeData() -> TimeChangeDto {
        let id = userDefaultsHelper.getStringData(key: "id")
        let getUpAt = userDefaultsHelper.getStringData(key: "wakeUpTime")
        let daysToAlarm = userDefaultsHelper.getArrayData(key: "dayOfWeekSelected") as? [Bool] ?? []
        let changeTimeData = TimeChangeDto(userId: id,getUpAt: getUpAt, daysToAlarm: daysToAlarm )
        
        return changeTimeData
    }
    
}
