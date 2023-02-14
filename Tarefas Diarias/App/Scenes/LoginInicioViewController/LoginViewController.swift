//
//  LoginViewController.swift
//  Tarefas Diarias
//
//  Created by user226298 on 1/31/23.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class LoginViewController: UIViewController {

    @IBOutlet weak var btnFacebook: UIButton!
    @IBOutlet weak var btnGoogle: UIButton!
    @IBOutlet weak var btnEmail: UIButton!
    @IBOutlet weak var logoEmail: UIImageView!
    @IBOutlet weak var btnCadastro: UIButton!
    //@IBOutlet weak var loginEmailView: UIView!
    
    private lazy var loginView: LoginView = {
        let view = LoginView(delegate: self)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var viewModel: LoginViewModel?
    var alert: Alert?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = LoginViewModel(delegate: self, viewController: self)
        alert = Alert(controller: self)

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
    
    @IBAction func tappedLoginEmail(_ sender: UIButton) {
        view.addSubview(loginView)
        UIView.animate(withDuration: 3, delay: 0, options: .curveEaseInOut) {
            NSLayoutConstraint.activate([
                self.loginView.topAnchor.constraint(equalTo: self.btnGoogle.bottomAnchor, constant: 5),
                self.loginView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 15),
                self.loginView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -15),
                self.loginView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            ])
        }
        UIView.animate(withDuration: 1) {
        }
    }
    
    @IBAction func tappedTarefas(_ sender: UIButton) {
        let tarefasVC = TarefasCriadasViewController()
        navigationController?.pushViewController(tarefasVC, animated: true)
    }
}
extension LoginViewController: LoginViewDelegate {
    
    func entrarClicado(email: String, password: String) {
        viewModel?.signIn(email: email, password: password)
    }
    
    func cancelarClicado1() {
        loginView.removeFromSuperview()
    }
}

extension LoginViewController: LoginViewModelDelegate{
    func goToTasks() {
        loginView.removeFromSuperview()
        loginView.clearFields()

        let tarefasVC = TarefasCriadasViewController()
        navigationController?.pushViewController(tarefasVC, animated: true)
    }
}
