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
    
    var delegate: LoginViewModelDelegate
    
    init(delegate: LoginViewModelDelegate){
        self.delegate = delegate
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
                    self.delegate.goToTasks()
                }
            }
        })
    }
}
