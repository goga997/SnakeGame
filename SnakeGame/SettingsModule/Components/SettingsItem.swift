//
//  SettingsItem.swift
//  SnakeGame
//
//  Created by Grigore on 24.05.2025.
//

import UIKit

enum SettingsItem: CaseIterable {
    case language, buyHearts, resetOnboarding, followOnSocials, appStoreReview
    
    var title: String {
        switch self {
        case .language: return "language_title".localized
        case .buyHearts: return "buy_hearts".localized
        case .resetOnboarding: return "reset_onboarding".localized
        case .followOnSocials: return "follow_socials".localized
        case .appStoreReview: return "app_review".localized
        }
    }
    
    var icon: UIImage? {
        switch self {
        case .language: return UIImage(systemName: "globe")
        case .buyHearts: return UIImage(systemName: "heart.fill")
        case .resetOnboarding: return UIImage(systemName: "arrow.counterclockwise")
        case .followOnSocials: return UIImage(systemName: "person.2")
        case .appStoreReview: return UIImage(systemName: "star.fill")
        }
    }
}
