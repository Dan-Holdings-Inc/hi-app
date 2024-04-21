//
//  SoundHelper.swift
//  Hi
//
//  Created by Yuma on 2024/04/16.
//

import SwiftUI
import AVFoundation

var musicPlayer: AVAudioPlayer!
let musicData = [NSDataAsset(name: "hoo")!.data,
                 NSDataAsset(name: "hey")!.data]

class SoundHelper {
    func playSound() {
        if let player = musicPlayer, player.isPlaying {
                    return
                }
        let randomIndex = Int.random(in: 0 ..< musicData.count)
        
        do {
            musicPlayer = try AVAudioPlayer(data: musicData[randomIndex])
            musicPlayer.currentTime = 0.0
            musicPlayer.play()
        } catch {
            print("音の再生に失敗しました。")
        }
    }
}
