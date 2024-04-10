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
    
    enum Path: Hashable {
        case main // メイン画面(ホーム、設定)
        case login // ログイン画面
        case accountCreateName // 名前.アカウント作成
        case accountCreateUserID // ユーザーID.アカウント作成
    }
    
    @MainActor func navigateToView(destination: Path) {
        navigationPath.append(destination)
    }
    
    @MainActor func backPage() {
        navigationPath.removeLast()
    }
}
