//
//  AlertPop.swift
//  Tarefas Diarias
//
//  Created by user226298 on 2/25/23.
//

import UIKit

class AlertPop {
    let controller: UIViewController
    
    init(controller: UIViewController) {
        self.controller = controller
    }
    
    func alertPop(title: String, message: String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { [self] (_) in
            controller.navigationController?.popViewController(animated: true)
        }
        alertController.addAction(okAction)
        controller.present(alertController, animated: true, completion: nil)
    }
}
