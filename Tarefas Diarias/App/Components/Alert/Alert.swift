//
//  Alert.swift
//  Tarefas Diarias
//
//  Created by user226298 on 2/1/23.
//

import UIKit

class Alert {
    let controller: UIViewController
    
    init(controller: UIViewController) {
        self.controller = controller
    }
    
    func alert(title: String, message: String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(ok)
        controller.present(alertController, animated: true)
    }
}
