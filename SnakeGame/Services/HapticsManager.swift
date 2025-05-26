//
//  HapticsManager.swift
//  SnakeGame
//
//  Created by Grigore on 20.12.2023.
//

import UIKit

final class HapticsManager {
    static let shared = HapticsManager()
    
    private var hapticsEnabled: Bool {
            return UserDefaults.standard.bool(forKey: "hapticsEnabled")
        }
    
    private init() {}
    
    public func selectionVibrate() {
        guard hapticsEnabled else { return }
        DispatchQueue.main.async {
            let selectionFeedbackGenerator = UISelectionFeedbackGenerator()
            selectionFeedbackGenerator.prepare()
            selectionFeedbackGenerator.selectionChanged()
        }
    }
    
    public func impactFeedback(for style: UIImpactFeedbackGenerator.FeedbackStyle) {
        guard hapticsEnabled else { return }
        DispatchQueue.main.async {
            let generator = UIImpactFeedbackGenerator(style: style)
            generator.prepare()
            generator.impactOccurred()
        }
    }
    
    public func vibrate(for type: UINotificationFeedbackGenerator.FeedbackType) {
        guard hapticsEnabled else { return }
        DispatchQueue.main.async {
            let notificationGenerator = UINotificationFeedbackGenerator()
            notificationGenerator.prepare()
            notificationGenerator.notificationOccurred(type)
        }
    }
}
