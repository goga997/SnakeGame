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
        case .language: return "Language"
        case .buyHearts: return "Buy Hearts"
        case .resetOnboarding: return "Reset Onboarding"
        case .followOnSocials: return "Follow on Socials"
        case .appStoreReview: return "AppStore Review"
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
