//
//  CustomTableViewCell.swift
//  Tarefas Diarias
//
//  Created by user226298 on 2/10/23.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var tituloTarefaLabel: UILabel!
    
    static let identifier: String = "CustomTableViewCell"
    static func nib()-> UINib{
        return UINib(nibName: self.identifier, bundle: nil)
    }
    
    var tasks = [[String: Any]]()

    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .cyan
        tituloTarefaLabel.layer.borderWidth = 2
        tituloTarefaLabel.layer.borderColor = UIColor.white.cgColor
        tituloTarefaLabel.layer.cornerRadius = 8
        tasks = UserDefaults.standard.array(forKey: "tasks") as? [[String: Any]] ?? []
    } 
}
