//
//  FriendSearchViewModel.swift
//  Hi
//
//  Created by Yuma on 2024/04/28.
//

import Foundation
import Combine

class FriendSearchViewModel: ObservableObject {
    @Published var userList: [User] = []
    
    private var cancellables: Set<AnyCancellable> = []
    
    func getUserList(searchWord: String) {
        FriendSearchModel.getUserList(searchWord: searchWord)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }, receiveValue: { data in
                DispatchQueue.main.async {
                    self.userList = data
                }
                print(data)
            })
            .store(in: &cancellables)
    }
}
