//
//  TabModel.swift
//  Hi
//
//  Created by Yuma on 2024/04/27.
//

import Foundation
import SwiftUI

enum Tab: String, CaseIterable {
    case home
    case account
    
    var label: Text {
        switch self {
        case .home:
            Text("Home")
        case .account:
            Text("Account")
        }
    }
    
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
