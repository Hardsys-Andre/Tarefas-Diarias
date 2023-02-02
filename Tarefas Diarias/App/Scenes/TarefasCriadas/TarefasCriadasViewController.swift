//
//  TarefasCriadasViewController.swift
//  Tarefas Diarias
//
//  Created by user226298 on 1/31/23.
//

import UIKit

class TarefasCriadasViewController: UIViewController {

    @IBOutlet weak var dataDoDia: UILabel!
    
    @IBOutlet weak var tarefasTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE - dd/MMM - yyyy"
        let result = formatter.string(from: date)
        dataDoDia.text = result
        
        tarefasTableView.delegate = self
        tarefasTableView.dataSource = self


  
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
