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
import SDWebImage

class TarefasCriadasViewController: UIViewController {

    @IBOutlet weak var dataDoDia: UILabel!
    @IBOutlet weak var userImageLogado: UIImageView!
    
    @IBOutlet weak var nomeUsuarioLogado: UILabel!
    @IBOutlet weak var tarefasTableView: UITableView!
    @IBOutlet weak var addTarefas: UIImageView!
    
    var tasks = [[String: Any]]()
    
    var items = [String]()
    let defaults = UserDefaults.standard
    
    var taskTitle: String?
    
    var emailLogin: String?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tarefasTableView.delegate = self
        tarefasTableView.dataSource = self
        tarefasTableView.register(CustomTableViewCell.nib(), forCellReuseIdentifier: CustomTableViewCell.identifier)
        
        if let emailLogin = emailLogin {
            tasks = (UserDefaults.standard.array(forKey: "tasks") as? [[String: Any]] ?? [])
                        .filter { $0["emailUsuario"] as? String == emailLogin }
            
            let userDefaults = UserDefaults.standard
            userDefaults.set(tasks, forKey: "tasks")
            UserDefaults.standard.synchronize()
            self.tarefasTableView.reloadData()
            
        }
        usuarioRecebido()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE - dd/MMM - yyyy"
        let result = formatter.string(from: date)
        dataDoDia.text = result
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tappedAddTarefas))
        addTarefas.isUserInteractionEnabled = true
        addTarefas.addGestureRecognizer(gesture)
    }
    
    var urlImage: String?
    var nomeUsuario: String?
    
    private func usuarioRecebido(){
        let db = Firestore.firestore()
        
        db.collection("users").whereField("email", isEqualTo: emailLogin as Any).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                guard let data = querySnapshot?.documents.first?.data() else { return }
                self.urlImage = (data["image"] as! String)
                self.nomeUsuario = (data["nome"] as! String)
                
                if let url = URL(string: self.urlImage ?? "") {
                    self.userImageLogado.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder.png"))
                    self.userImageLogado.layer.borderWidth = 2
                    self.userImageLogado.layer.borderColor = UIColor.systemCyan.cgColor
                    self.userImageLogado.layer.cornerRadius = 10
                }
                self.nomeUsuarioLogado.text = self.nomeUsuario
            }
        }
    }
    @objc func tappedAddTarefas(){
        let addTarefas = CadastrarTarefasViewController()
        addTarefas.emailLogado = emailLogin
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

        if emailLogin == (task["emailUsuario"] as? String){
            let taskTitle = task["titulo"] as? String
            let taskDate = task["data"] as? String
            let taskTitleAndDate = taskTitle! + " - " + taskDate!
            cell?.tituloTarefaLabel.text = taskTitleAndDate
        }
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let task = tasks[indexPath.row]
        
        if emailLogin == (task["emailUsuario"] as? String){
            let title = tasks[indexPath.row]["titulo"] as? String
            let taskDetailsViewController = ExibirTarefasCadastradasVC()
            taskDetailsViewController.taskTitle = title
            
            navigationController?.pushViewController(taskDetailsViewController, animated: true)
        }
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
