//
//  LoginView.swift
//  Tarefas Diarias
//
//  Created by user226298 on 2/1/23.
//

import UIKit

protocol LoginViewDelegate {
    func entrarClicado(email: String, password: String)
    func cancelarClicado1()
}

class LoginView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var btnEmailEntrar: UIButton!
    @IBOutlet weak var btnEmailCancelar: UIButton!
    
    var delegate: LoginViewDelegate?
    
    init(delegate: LoginViewDelegate) {
        super.init(frame: .zero)
        setupView()
        self.delegate = delegate
    }
    
    func setupView() {
        Bundle.main.loadNibNamed("LoginView", owner: self)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction private func entrarClicado() {
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        delegate?.entrarClicado(email: email, password: password)
    }
    
    @IBAction private func cancelarClicado() {
        delegate?.cancelarClicado1()
    }
    
    func clearFields() {
        emailTextField.text = nil
        passwordTextField.text = ""
    }
}
