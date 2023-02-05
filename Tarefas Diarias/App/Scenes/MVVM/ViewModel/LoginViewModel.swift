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
    //var alert: Alert?
    
    var delegate: LoginViewModelDelegate
    
    init(delegate: LoginViewModelDelegate){
        self.delegate = delegate
        //alert = Alert(controller: self)
    }

    func signIn(email: String, password: String){

        self.auth = Auth.auth()
        

        self.auth?.signIn(withEmail: email, password: password, completion: { usuario, error in
            if error != nil{
                print ("Dados incorretos, tente novamente")
                //self.alert?.alert(title: "Atenção", message: "Dados incorretos, tente novamente")
            }else{
                if usuario == nil{
                    print("Tivemos um problema inesperado")
                    //self.alert?.alert(title: "Atenção", message: "Tivemos um problema inesperado")
                    
                }else{
                    print("Login feito com sucesso")
                    self.getDados()
                    
                }
            }
        })
    }
    
    func getDados(){
        
        let db = Firestore.firestore()
        
        db.collection("users").whereField("email", isEqualTo: "andre@gmail.com").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                print(querySnapshot?.documents.first?.data())
                self.delegate.goToTasks()
            }
        }
    }
}
