//
//  LocalNotificationsService.swift
//  Navigation
//
//  Created by Филипп Степанов on 16.12.2022.
//

import Foundation
import UserNotifications
import UIKit

final class LocalNotificationsService {
    
    let center = UNUserNotificationCenter.current()
    
    func registerForLatestUpdatesIfPossible() {
        registerUpdatesCategory()
        
        center.requestAuthorization(options: [.alert, .sound, .badge]) { [weak self] success, error in
            if let error = error {
                print(error.localizedDescription)
            }
            
            if success {
                self?.setNotification()
            }
        }
    }
    
    private func setNotification() {
        let content = UNMutableNotificationContent()
        content.sound = .default
        content.body = "Посмотрите последние обновления"
        content.categoryIdentifier = "updates"
        DispatchQueue.main.async {
            content.badge = (UIApplication.shared.applicationIconBadgeNumber + 1) as NSNumber
        }
        
        var date = DateComponents()
        date.hour = 19
        date.minute = 00
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString,
                                            content: content, trigger: trigger)
        
        center.add(request)
    }
    
    private func registerUpdatesCategory() {
        var action: UNNotificationAction
        
        if #available(iOS 15.0, *) {
            let actionShow = UNNotificationAction(identifier: "show", title: "Показать", options: .foreground, icon: .init(systemImageName: "eye"))
            action = actionShow
        } else {
            let actionShow = UNNotificationAction(identifier: "show", title: "Показать", options: .foreground)
            action = actionShow
        }
        let actions: [UNNotificationAction] = [action]
        
        let category = UNNotificationCategory(identifier: "updates", actions: actions, intentIdentifiers: [])
        
        let categories: Set<UNNotificationCategory> = [category]
        center.setNotificationCategories(categories)
    }
        
}
