//
//  AppPoliciesItem.swift
//  SnakeGame
//
//  Created by Grigore on 26.05.2025.
//

import UIKit

enum AppPoliciesItem: CaseIterable {
    case termsOfUse, privacy, legalNotice
    
    var title: String {
        switch self {
        case .termsOfUse: return "Terms of Use"
        case .privacy: return "Privacy"
        case .legalNotice: return "Legal Notice"
        
        }
    }
    
    var icon: UIImage? {
        switch self {
        case .termsOfUse: return UIImage(systemName: "text.justify.left")
        case .privacy: return UIImage(systemName: "lock.shield")
        case .legalNotice: return UIImage(systemName: "note.text")
        }
    }
}
