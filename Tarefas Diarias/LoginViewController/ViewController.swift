//
//  ViewController.swift
//  Tarefas Diarias
//
//  Created by user226298 on 1/31/23.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var loginFace: UIButton!
    @IBOutlet weak var loginGoogle: UIButton!
    @IBOutlet weak var loginEmail: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginFace.layer.cornerRadius = 8
        loginGoogle.layer.cornerRadius = 8
        loginEmail.layer.cornerRadius = 8

    }


}

