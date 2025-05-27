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
        case .termsOfUse: return "settings_terms_of_use".localized
        case .privacy: return "settings_privacy".localized
        case .legalNotice: return "settings_legal_notice".localized
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
