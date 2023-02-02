//
//  CadastroViewController.swift
//  Tarefas Diarias
//
//  Created by user226298 on 1/31/23.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import Firebase

class CadastroViewController: UIViewController {
    
    @IBOutlet weak var nomeTexteField: UITextField!
    
    @IBOutlet weak var sobrenomeTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var senhaTextField: UITextField!
    
    
    @IBOutlet weak var btnCadastrar: UIButton!
    
    var auth:Auth?
    var alert:Alert?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.auth = Auth.auth()
        alert = Alert(controller: self)
        btnCadastrar.layer.cornerRadius = 8
        
    }

   
  
    @IBAction func tappedCadastras(_ sender: UIButton) {
        
        let db = Firestore.firestore()

        let userData: [String: Any] = [
            "nome": "João",
            "sobrenome": "Silva",
            "email": "joaosilva@example.com"
        ]

        db.collection("users").addDocument(data: userData) { (error) in
            if let error = error {
                print("Erro ao salvar usuário: \(error)")
            } else {
                print("Usuário salvo com sucesso")
            }
        }

        
        let email: String = self.emailTextField.text ?? ""
        let senha: String = self.senhaTextField.text ?? ""
        
        
        self.auth?.createUser(withEmail: email, password: senha, completion: { Result, error in
            if error != nil {
                self.alert?.alert(title: "Atenção", message: "Falha ao cadastrar")

            }else{
                self.alert?.alert(title: "Parabéns", message: "Cadastro realizado com sucesso")
            }
        })
    }
    
}
