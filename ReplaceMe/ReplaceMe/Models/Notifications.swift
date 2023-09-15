//
//  Notifications.swift
//  ReplaceMe
//
//  Created by Cesar Fuentes on 9/15/23.
//

import SwiftUI
import Foundation

func requestAuthorization() -> Void {
    let center = UNUserNotificationCenter.current()
    
    center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
        
        if let error = error {
            // Handle the error here.
        }
        
        // Enable or disable features based on the authorization.
        print("accessGranted? \(granted)")
        return
    }
    
}

func createLocalNotifiation(item: Item) -> Void {
    
    // TODO: if editing, cancel previous notification request
    
    // create new notification request
    let center = UNUserNotificationCenter.current()
    center.getNotificationSettings { settings in
        guard (settings.authorizationStatus == .authorized) ||
              (settings.authorizationStatus == .provisional) else { return }

        if settings.alertSetting == .enabled {
            // Schedule an alert-only notification.
            
            // Configuring the notification content
            let content = UNMutableNotificationContent()
            content.title = "ReplaceMe"
            content.body = "It's time to replace your \(item.name)" // TODO: replace with action
            let reminderDate = item.getReminderDate()
                        
            // Configure the recurring date.
            var dateComponents = DateComponents()
            dateComponents.calendar = Calendar.current
            dateComponents = Calendar.current.dateComponents([.year, .month, .weekOfYear, .day], from: reminderDate)
            dateComponents.hour = 9    // TODO: replace with set time
            dateComponents.minute = 0
            
            // Create the trigger as a repeating event.
            let trigger = UNCalendarNotificationTrigger(
                     dateMatching: dateComponents, repeats: false)
            
            // Create the request
            let uuidString = UUID().uuidString
            let request = UNNotificationRequest(identifier: uuidString,
                        content: content, trigger: trigger)

            // Schedule the request with the system.
            let notificationCenter = UNUserNotificationCenter.current()
            notificationCenter.add(request) { (error) in
               if error != nil {
                  // Handle any errors.
               }
            }

        }
        
    }
    
    // TODO: add new notification when replaceme is pressed

}
