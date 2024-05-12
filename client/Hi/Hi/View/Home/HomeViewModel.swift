//
//  HomeViewModel.swift
//  Hi
//
//  Created by Yuma on 2024/04/09.
//

import Foundation
import SwiftUI
import Combine

class HomeViewModel: ObservableObject {
    let soundHelper = SoundHelper()
    private var cancellables: Set<AnyCancellable> = []
    
    func userCardButtonAction(name: String) {
        print("\(name)にHiを送信")
        soundHelper.playSound()
    }
    
    func postHi(friendId: String) {
        let userDefaults = UserDefaultsHelper()
        let idToken = userDefaults.getStringData(key: UserDefaultsKey.idToken)
        print(idToken)
        
        HomeModel.pushHi(friendId: friendId, idToken: idToken) { error in
            if let error = error {
                print("Hi送信エラーが発生しました: \(error)")
            }
        }
    }
}
