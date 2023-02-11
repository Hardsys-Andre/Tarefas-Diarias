//
//  ExibirTarefasCadastradasVC.swift
//  Tarefas Diarias
//
//  Created by user226298 on 2/10/23.
//

import UIKit

class ExibirTarefasCadastradasVC: UIViewController {
    
    @IBOutlet weak var tituloTarefa: UITextField!
    
    @IBOutlet weak var descricaoTarefa: UITextField!
    
    @IBOutlet weak var prioridadeTarefa: UITextField!
    
    @IBOutlet weak var dataTarefa: UITextField!
    
    @IBOutlet weak var horarioTarefa: UITextField!
    
    @IBOutlet weak var categoriaTarefa: UITextField!
    
    
    
    
    var taskTitle: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        descricaoTarefa.contentVerticalAlignment = .top
        
        guard let title = taskTitle else {return}

        let taskDictionary = UserDefaults.standard.array(forKey: "tasks") as? [[String: Any]] ?? []

        let task = taskDictionary.first(where: { ($0["titulo"] as? String) == title })

        if let task = task {
            tituloTarefa.text = task["titulo"] as? String
            descricaoTarefa.text = task["descricao"] as? String
            prioridadeTarefa.text = task["prioridade"] as? String
            dataTarefa.text = task["data"] as? String
            horarioTarefa.text = task["horario"] as? String
            categoriaTarefa.text = task["categoria"] as? String
            }
        }
}
