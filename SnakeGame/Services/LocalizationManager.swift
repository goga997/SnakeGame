//
//  LocalizationManager.swift
//  SnakeGame
//
//  Created by Grigore on 27.05.2025.
//

import Foundation

final class LocalizationManager {
    static let shared = LocalizationManager()
    
    enum Language: String, CaseIterable {
        case english = "en"
        case russian = "ru"
        case spanish = "es"
        case french = "fr"
        
        var displayName: String {
            switch self {
            case .english: return "English"
            case .russian: return "Русский"
            case .spanish: return "Español"
            case .french: return "Français"
            }
        }
    }
    
    private let languageKey = "selectedLanguage"
    
    var currentLanguage: Language {
        get {
            let code = UserDefaults.standard.string(forKey: languageKey) ?? Language.english.rawValue
            return Language(rawValue: code) ?? .english
        }
        
        set {
            UserDefaults.standard.set(newValue.rawValue, forKey: languageKey)
            NotificationCenter.default.post(name: .languageChanged, object: nil)
        }
    }
    
    func localizedString(forKey key: String) -> String {
        guard
            let path = Bundle.main.path(forResource: currentLanguage.rawValue, ofType: "lproj"),
            let bundle = Bundle(path: path)
        else {
            return NSLocalizedString(key, comment: "")
        }
        return NSLocalizedString(key, tableName: nil, bundle: bundle, value: "", comment: "")
    }
    
}

extension Notification.Name {
    static let languageChanged = Notification.Name("languageChanged")
}
