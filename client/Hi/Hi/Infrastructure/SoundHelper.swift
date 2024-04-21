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
    private var lastButtonPressedTime = Date(timeIntervalSince1970: 0)
    
    func playSound() {
        let currentTime = Date()
        if currentTime.timeIntervalSince(lastButtonPressedTime) < 0.5 {
            // 直前のボタン押下から1秒以内であれば、音を再生しない
            return
        }
        
        let randomIndex = Int.random(in: 0 ..< musicData.count)
        
        do {
            musicPlayer = try AVAudioPlayer(data: musicData[randomIndex])
            musicPlayer.currentTime = 0.0
            musicPlayer.play()
            
            // ボタンが押された時刻を更新
            lastButtonPressedTime = currentTime
        } catch {
            print("音の再生に失敗しました。")
        }
    }
}
