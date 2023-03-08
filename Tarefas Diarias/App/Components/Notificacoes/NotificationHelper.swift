//
//  NotificationHelper.swift
//  Tarefas Diarias
//
//  Created by user226298 on 2/17/23.
//

import UserNotifications

class NotificationHelper {
    static let shared = NotificationHelper()
    
    func scheduleNotification(at date: Date, title: String, body: String, userEmail: String) {
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = UNNotificationSound.default
        content.userInfo = ["userEmail": userEmail]
       
        
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        
        let request = UNNotificationRequest(identifier: title, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
}
