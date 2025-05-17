//
//  HeartManager.swift
//  SnakeGame
//
//  Created by Grigore on 16.02.2025.
//

import Foundation

struct HeartManager {
    private static let heartsKey = "heartsCount"
    private static let lastResetKey = "lastResetDate"
    static let heartsUpdatedNotification = Notification.Name("heartsUpdated")

    static var hearts: Int {
        get {
            return UserDefaults.standard.integer(forKey: heartsKey)
        }
        set {
            UserDefaults.standard.set(max(0, newValue), forKey: heartsKey)
            NotificationCenter.default.post(name: heartsUpdatedNotification, object: nil)
        }
    }

    static func resetHearts() {
        if hearts < 3 { // do not reset if there are already 3+
            hearts = 3
            UserDefaults.standard.set(Date(), forKey: lastResetKey)
        }
    }

    static func checkResetIfNeeded() { //this function is called in Controller in viewDidLoad only once when app is loaded
        let now = Date()
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: now)

        var lastResetDate: Date? = nil
        
        if let storedValue = UserDefaults.standard.object(forKey: lastResetKey),
           let dateValue = storedValue as? Date {
            lastResetDate = dateValue
        } else {
            #if DEBUG
            print("⚠️ Warning: 'lastResetKey' is missing or not a Date.")
            #endif
        }

        if let lastDate = lastResetDate,
           calendar.isDate(lastDate, inSameDayAs: today) {
            return
        }

        if hearts < 3 {
            hearts = 3
        }
        UserDefaults.standard.set(today, forKey: lastResetKey)
    }

}
