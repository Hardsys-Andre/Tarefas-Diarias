//
//  LoginViewController.swift
//  Tarefas Diarias
//
//  Created by user226298 on 1/31/23.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var btnFacebook: UIButton!
    
    @IBOutlet weak var btnGoogle: UIButton!
    
    @IBOutlet weak var btnEmail: UIButton!
    
    @IBOutlet weak var btnCadastro: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnFacebook.layer.cornerRadius = 8
        btnFacebook.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        
        btnGoogle.layer.cornerRadius = 8
        btnGoogle.titleLabel?.font = UIFont.systemFont(ofSize: 20)

        btnEmail.layer.cornerRadius = 8
        btnEmail.titleLabel?.font = UIFont.systemFont(ofSize: 20)

        btnCadastro.layer.cornerRadius = 8
        btnCadastro.titleLabel?.font = UIFont.systemFont(ofSize: 20)
       
    }

    @IBAction func tappedCadastro(_ sender: UIButton) {
        let loginVC = CadastroViewController()
        navigationController?.pushViewController(loginVC, animated: true)
    }
}
