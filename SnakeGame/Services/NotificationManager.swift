//
//  NotificationManager.swift
//  SnakeGame
//
//  Created by Grigore on 26.05.2025.
//

import Foundation
import UserNotifications

final class NotificationManager {
    static let shared = NotificationManager()
    
    //defined key for notifs in teh settings
    let notificationToggleKey = "notificationsEnabled"
    
    
    
    private init() {}
    
    //check if permision was asked already
    private let userAskedKey = "notificationPermissionAsked"

    public func requestAuthorizationIfNeeded(completion: @escaping (Bool) -> Void) {
        let wasAsked = UserDefaults.standard.bool(forKey: userAskedKey)
        
        guard !wasAsked else {
            UNUserNotificationCenter.current().getNotificationSettings { settings in
                completion(settings.authorizationStatus == .authorized)
            }
            return
        }
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, _ in
            UserDefaults.standard.set(true, forKey: self.userAskedKey)
            completion(granted)
        }
    }
    
    
    public func isAuthorized(completion: @escaping (Bool) -> Void) {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            completion(settings.authorizationStatus == .authorized)
        }
    }
    
    public func cancelAllNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }

    
    public func sendHeartsRestoredNotification() {
        let notificationsEnabled = UserDefaults.standard.bool(forKey: "notificationsEnabled")

        guard notificationsEnabled else { return }

        let content = UNMutableNotificationContent()
        content.title = "❤️ Hearts Restored!"
        content.body = "Now you can play again with 3 new hearts!"
        content.sound = .default

        var dateComponents = DateComponents()
        dateComponents.hour = 0
        dateComponents.minute = 1

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: "hearts_restored", content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request)
    }
    
    public func scheduleThreeDailyPremiumReminders() {
        let notificationsEnabled = UserDefaults.standard.bool(forKey: "notificationsEnabled")
        let isPremium = UserDefaults.standard.bool(forKey: "isPremium")

        guard notificationsEnabled && !isPremium else { return }

        let center = UNUserNotificationCenter.current()

        let times = [
            (hour: 8, identifier: "premium_reminder_8"),
            (hour: 12, identifier: "premium_reminder_12"),
            (hour: 18, identifier: "premium_reminder_18")
        ]

        for time in times {
            let content = UNMutableNotificationContent()
            content.title = "💎 Become Premium"
            content.body = "Play without ads and enjoy unlimited hearts!"
            content.sound = .default

            var dateComponents = DateComponents()
            dateComponents.hour = time.hour
            dateComponents.minute = 0

            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

            let request = UNNotificationRequest(
                identifier: time.identifier,
                content: content,
                trigger: trigger
            )

            center.add(request)
        }
    }

   
}
