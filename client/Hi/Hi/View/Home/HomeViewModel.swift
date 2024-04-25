//
//  HomeViewModel.swift
//  Hi
//
//  Created by Yuma on 2024/04/09.
//

import Foundation
import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var followUsers: [UserWithRelationship] = []
    @Published var cardColors: [Color] = [.pink, .blue, .green, .gray, .yellow]
    
    let soundHelper = SoundHelper()
    
    func userCardButtonAction(name: String) {
        print("\(name)にHiを送信")
        soundHelper.playSound()
    }
}
