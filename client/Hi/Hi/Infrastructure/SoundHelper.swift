//
//  SoundHelper.swift
//  Hi
//
//  Created by Yuma on 2024/04/16.
//

import SwiftUI
import AVFoundation

let musicData = NSDataAsset(name: "se")!.data
var musicPlayer: AVAudioPlayer!

class SoundHelper {
    func playSound() {
        do {
            musicPlayer = try AVAudioPlayer(data: musicData)
            musicPlayer.currentTime = 0.0
            musicPlayer.play()
        } catch {
            print("音の再生に失敗しました。")
        }
    }
}
