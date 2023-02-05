//
//  TarefasCriadasViewController.swift
//  Tarefas Diarias
//
//  Created by user226298 on 1/31/23.
//

import UIKit
import FirebaseDatabase
import FirebaseCore
import FirebaseFirestore

class TarefasCriadasViewController: UIViewController {

    @IBOutlet weak var dataDoDia: UILabel!
    
    @IBOutlet weak var userImageLogado: UIImageView!
    @IBOutlet weak var tarefasTableView: UITableView!
    
    @IBOutlet weak var addTarefas: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE - dd/MMM - yyyy"
        let result = formatter.string(from: date)
        dataDoDia.text = result
        
        tarefasTableView.delegate = self
        tarefasTableView.dataSource = self
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tappedAddTarefas))
        addTarefas.isUserInteractionEnabled = true
        addTarefas.addGestureRecognizer(gesture)
   
  
    }
    
    @objc func tappedAddTarefas(){
        let addTarefas = CadastrarTarefasViewController()
        navigationController?.pushViewController(addTarefas, animated: true)
    }

    
}
extension TarefasCriadasViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.backgroundColor = .systemCyan
        return cell
    }
    
    
}
