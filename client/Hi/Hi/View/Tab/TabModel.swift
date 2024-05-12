//
//  TabModel.swift
//  Hi
//
//  Created by Yuma on 2024/04/27.
//

import Foundation

enum Tab: String, CaseIterable {
    case home = "ホーム"
    case account = "アカウント"
    
    var systemImage: String {
        switch self {
            
        case .home:
            return "house"
        case .account:
            return "person"
        }
    }
    
    var index: Int {
        return Tab.allCases.firstIndex(of: self) ?? 0
    }
}
