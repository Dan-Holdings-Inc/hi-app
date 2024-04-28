//
//  DeleteViewModel.swift
//  Hi
//
//  Created by ryosei on 2024/04/28.
//

import Foundation
import Combine

class DeleteViewModel: ObservableObject {
    @Published var userList: [User] = []
    
    private var cancellables: Set<AnyCancellable> = []
    
    func DeleteFriend(friendId: String) {
        let userDefaults = UserDefaultsHelper()
        let id = userDefaults.getStringData(key: "id")
        let newdeleteDto = DeleteDto(followsId: friendId)
        
        DeleteModel.DeleteData(deleteDto: newdeleteDto, id: id)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("削除完了")
                    break
                case .failure(let error):
                    print(error.errorDescription)
                }
            }, receiveValue: { data in
                print(data)
            })
            .store(in: &cancellables)
    }
}

