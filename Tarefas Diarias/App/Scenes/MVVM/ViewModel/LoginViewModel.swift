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

class LoginViewModel{
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
                    
                    
                    // Obtenha a instância atual do UNUserNotificationCenter
                    let center = UNUserNotificationCenter.current()

                    // Obtenha as notificações pendentes
                    center.getPendingNotificationRequests(completionHandler: { requests in
                        // Verifique se há notificações para o dia atual
                        let today = Date()
                        let formatter = DateFormatter()
                        formatter.dateFormat = "yyyy-MM-dd"
                        let todayString = formatter.string(from: today)

                        var hasTasksForToday = false
                        for request in requests {
                            if let trigger = request.trigger as? UNCalendarNotificationTrigger,
                               let date = trigger.nextTriggerDate() {
                                let dateString = formatter.string(from: date)
                                if dateString == todayString {
                                    hasTasksForToday = true
                                    break
                                }
                            }
                        }

                        // Se houver tarefas agendadas para hoje, mostre um alerta na tela
                        if hasTasksForToday {
                            self.alert?.alert(title: "Atenção", message: "Você tem tarefas agendadas para o dia de hoje")

                        }
                    })

                    
                    
                    
                    
                    
                    self.getDados()
                }
            }
        })
    }
    
    func getDados(){
        
        /*let db = Firestore.firestore()
        
        db.collection("users").whereField("email", isEqualTo: "hardsys@gmail.com").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                guard let data = querySnapshot?.documents.first?.data() else { return }
                
                print(data)*/
                self.delegate?.goToTasks()
            }
        //}
    //}
}
