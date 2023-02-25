//
//  NotificationHelper.swift
//  Tarefas Diarias
//
//  Created by user226298 on 2/17/23.
//

import UserNotifications
import UIKit

class NotificationHelper {
    static let shared = NotificationHelper()
    
    
   
    
    
    func scheduleNotification(at date: Date, title: String, body: String) {
        
      print(title)
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = UNNotificationSound.default
        
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        
        let request = UNNotificationRequest(identifier: title, content: content, trigger: trigger)
        //let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
}

