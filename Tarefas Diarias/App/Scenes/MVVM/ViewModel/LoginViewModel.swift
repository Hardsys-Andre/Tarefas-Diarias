//
//  LoginViewModel.swift
//  Tarefas Diarias
//
//  Created by user226298 on 2/1/23.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

protocol LoginViewModelDelegate{
    func goToTasks()
}

class LoginViewModel {
    var auth:Auth?
    var alert: Alert?
    
    var delegate: LoginViewModelDelegate?
    
    let viewController: UIViewController
   
    init(delegate: LoginViewModelDelegate, viewController: UIViewController){
        self.delegate = delegate
        self.viewController = viewController
        alert = Alert(controller: viewController)
    }

    func signIn(email: String, password: String){

        self.auth = Auth.auth()
        
        self.auth?.signIn(withEmail: email, password: password, completion: { usuario, error in
            if error != nil{
                self.alert?.alert(title: "Atenção", message: "Dados incorretos, tente novamente")
            }else{
                if usuario == nil{
                    self.alert?.alert(title: "Atenção", message: "Tivemos um problema inesperado")
                }else{
                    print("Login feito com sucesso")
                    
                    let center = UNUserNotificationCenter.current()
                    
                    let userEmail = email

                    center.getPendingNotificationRequests(completionHandler: { requests in
                        let today = Date()
                        let formatter = DateFormatter()
                        formatter.dateFormat = "yyyy-MM-dd"
                        let todayString = formatter.string(from: today)

                        var hasTasksForToday = false
                        for request in requests {
                            
                            if let trigger = request.trigger as? UNCalendarNotificationTrigger,
                                       let date = trigger.nextTriggerDate(),
                                       let userInfo = request.content.userInfo as? [String: Any],
                                       let requestUserEmail = userInfo["userEmail"] as? String {
                                        let dateString = formatter.string(from: date)
                                        if dateString == todayString && requestUserEmail == userEmail {
                                            hasTasksForToday = true
                                            break
                                }
                            }
                        }

                        if hasTasksForToday {
                            self.alert?.alert(title: "Atenção", message: "Você tem tarefas agendadas para o dia de hoje")
                        }
                    })
                    
                    self.delegate?.goToTasks()
                }
            }
        })
    }
}
