//
//  Colors.swift
//  Hi
//
//  Created by Yuma on 2024/04/27.
//

import SwiftUI

struct Colors {
    static let cardColors: [LinearGradient] = [
        // 紫
        LinearGradient(
            gradient: Gradient(colors: [
                Color(red: 0.22, green: 0.59, blue: 0.96),
                Color(red: 0.80, green: 0.19, blue: 0.92)
            ]),
            startPoint: .leading,
            endPoint: .trailing
        ),
        // 青
        LinearGradient(
            gradient: Gradient(colors: [
                Color(red: 0.19, green: 0.58, blue: 0.91),
                Color(red: 0.10, green: 0.40, blue: 0.75)
            ]),
            startPoint: .leading,
            endPoint: .trailing
        ),
        // オレンジ
        LinearGradient(
            gradient: Gradient(colors: [
                Color(red: 0.96, green: 0.63, blue: 0.22),
                Color(red: 0.95, green: 0.40, blue: 0.09)
            ]),
            startPoint: .leading,
            endPoint: .trailing
        ),
        // 水色
        LinearGradient(
            gradient: Gradient(colors: [
                Color(red: 0.22, green: 0.8, blue: 0.8),
                Color(red: 0.0, green: 0.6, blue: 0.8)
            ]),
            startPoint: .leading,
            endPoint: .trailing
        ),
        // ピンク
        LinearGradient(
            gradient: Gradient(colors: [
                Color(red: 0.95, green: 0.44, blue: 0.75),
                Color(red: 0.91, green: 0.18, blue: 0.63)
            ]),
            startPoint: .leading,
            endPoint: .trailing
        ),
        // 黄緑
        LinearGradient(
            gradient: Gradient(colors: [
                Color(red: 0.75, green: 0.94, blue: 0.35),
                Color(red: 0.18, green: 0.80, blue: 0.44)
            ]),
            startPoint: .leading,
            endPoint: .trailing
        ),
        // 黄
        LinearGradient(
            gradient: Gradient(colors: [
                Color(red: 0.98, green: 0.96, blue: 0.36),
                Color(red: 0.98, green: 0.76, blue: 0.18)
            ]),
            startPoint: .leading,
            endPoint: .trailing
        )
    ]
    static let mobColor: LinearGradient = LinearGradient(colors: [.gray], startPoint: .leading, endPoint: .trailing)
}
