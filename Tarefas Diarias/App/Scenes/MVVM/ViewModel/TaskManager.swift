//
//  TaskManager.swift
//  Tarefas Diarias
//
//  Created by user226298 on 2/24/23.
//

import Foundation
import NotificationCenter

class TaskManager {
    
    static let shared = TaskManager()
    
    private let userDefaults = UserDefaults.standard
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        return formatter
    }()
    
    func removeOldTasks() {
        let tasks = userDefaults.array(forKey: "tasks") as? [[String: Any]] ?? []
        let currentDate = Date()
        let newTasks = tasks.filter { task in
            if let dateString = task["data"] as? String, let date = dateFormatter.date(from: dateString) {
                return date >= currentDate
            }
            return true
        }
        userDefaults.set(newTasks, forKey: "tasks")
    }
}

