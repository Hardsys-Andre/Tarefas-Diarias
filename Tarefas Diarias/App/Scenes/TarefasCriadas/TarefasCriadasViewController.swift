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
import FirebaseAuth

protocol UpdateTableDelegate: AnyObject {
    func updateTable()
}

class TarefasCriadasViewController: UIViewController {
    
    
    
    var delegate: UpdateTableDelegate?
    
    override func prepare(for segue: UIStoryboardSegue, sender: (Any)?){
        if segue.identifier == "segueCadastro" {
            let cadastroVC = segue.destination as? TarefasCriadasViewController
            cadastroVC?.delegate = self
        }
    }

    @IBOutlet weak var dataDoDia: UILabel!
    
    @IBOutlet weak var userImageLogado: UIImageView!
    @IBOutlet weak var tarefasTableView: UITableView!
    
    @IBOutlet weak var addTarefas: UIImageView!
    
    var tasks = [[String: Any]]()
    
    
    var items = [String]()
    let defaults = UserDefaults.standard
    
    var taskTitle: String?
    
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        delegate = self
        items = defaults.array(forKey: "tasks") as? [String] ?? [String]()
        
        tasks = UserDefaults.standard.array(forKey: "tasks") as? [[String: Any]] ?? []

        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE - dd/MMM - yyyy"
        let result = formatter.string(from: date)
        dataDoDia.text = result
        
        tarefasTableView.delegate = self
        tarefasTableView.dataSource = self
        tarefasTableView.register(CustomTableViewCell.nib(), forCellReuseIdentifier: CustomTableViewCell.identifier)
        self.tarefasTableView.reloadData()
        
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
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as? CustomTableViewCell
        cell?.backgroundColor = .systemCyan
        let task = tasks[indexPath.row]
        
        let taskTitle = task["titulo"] as? String
        let taskDate = task["data"] as? String
        let taskTitleAndDate = taskTitle! + " - " + taskDate!
        cell?.tituloTarefaLabel.text = taskTitleAndDate
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        let title = tasks[indexPath.row]["titulo"] as? String
                
                let taskDetailsViewController = ExibirTarefasCadastradasVC()
                taskDetailsViewController.taskTitle = title
                navigationController?.pushViewController(taskDetailsViewController, animated: true)
            
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            tasks.remove(at: indexPath.row)
            defaults.set(tasks, forKey: "tasks")
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 63
    }
}

extension TarefasCriadasViewController: UpdateTableDelegate{
    func updateTable() {
        print("quero muito")
        
        tarefasTableView.reloadData()
    
    }
    
    
}
