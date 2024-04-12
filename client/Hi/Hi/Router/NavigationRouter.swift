//
//  NavigationRouter.swift
//  Hi
//
//  Created by Yuma on 2024/04/09.
//

import SwiftUI
import Foundation

final class NavigationRouter: ObservableObject {
    @MainActor @Published var navigationPath: [Path] = []
    @Published var settingNavigationPath: [Path] = [.settingName, .settingUserID, .settingWakuUpTime, .settingDayOfWeek]
    
    enum Path: Hashable {
        case main // メイン画面(ホーム、設定)
        case login // ログイン画面
        // アカウント作成
        case accountCreateName
        case accountCreateUserID
        case accountCreateWakeUpTime
        case accountCreateDayOfWeek
        // 設定
        case settingName
        case settingUserID
        case settingWakuUpTime
        case settingDayOfWeek
    }
    
    @MainActor func navigateToView(destination: Path) {
        navigationPath.append(destination)
    }
    
    @MainActor func backPage() {
        navigationPath.removeLast()
    }
    
    @MainActor func resetPath() {
        navigationPath.removeAll()
    }
}
