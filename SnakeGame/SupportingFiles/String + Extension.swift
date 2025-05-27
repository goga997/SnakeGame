//
//  String + Extension.swift
//  SnakeGame
//
//  Created by Grigore on 27.05.2025.
//

import Foundation

extension String {
    var localized: String {
        return LocalizationManager.shared.localizedString(forKey: self)
    }
}
