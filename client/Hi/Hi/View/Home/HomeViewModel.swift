//
//  HomeViewModel.swift
//  Hi
//
//  Created by Yuma on 2024/04/09.
//

import Foundation
import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var cardColors: [Color] = [.pink, .blue, .green, .gray, .yellow]
    
    let soundHelper = SoundHelper()
    
    func userCardButtonAction(name: String) {
        print("\(name)にHiを送信")
        soundHelper.playSound()
    }
    
    func postHi(friendId: String) {
        let userDefaults = UserDefaultsHelper()
        let idToken = userDefaults.getStringData(key: "idToken")
        print(idToken)
        
        HomeModel.pushHi(friendId: friendId, idToken: idToken) { error in
            if let error = error {
                print("Hi送信エラーが発生しました: \(error)")
            }
        }
    }
}
