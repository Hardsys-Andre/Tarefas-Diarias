//
//  CadastrarTarefasViewController.swift
//  Tarefas Diarias
//
//  Created by user226298 on 2/5/23.
//

import UIKit

/*protocol UpdateTableDelegate: AnyObject {
    func updateTable()
}*/

class CadastrarTarefasViewController: UIViewController {
    
        
        weak var delegate: UpdateTableDelegate?
        

        
        @IBOutlet weak var tituloTarefaTextField: UITextField!
        
        @IBOutlet weak var descricaoTarefasTextField: UITextField!
        @IBOutlet weak var btnImportante: UIButton!
        
        @IBOutlet weak var btnComum: UIButton!
        
        @IBOutlet weak var btnEscolherData: UIButton!
        
        @IBOutlet weak var btnEscolherHorario: UIButton!
        
        @IBOutlet weak var dataView: UIView!
        
        @IBOutlet weak var horarioView: UIView!
        
        @IBOutlet weak var dataPickerData: UIDatePicker!
        
        @IBOutlet weak var dataPickerHora: UIDatePicker!
        
        @IBOutlet weak var btnAlimentacao: UIButton!
        
        @IBOutlet weak var btnSaude: UIButton!
        
        @IBOutlet weak var btnEsportes: UIButton!
        
        @IBOutlet weak var btnTrabalho: UIButton!
        
        @IBOutlet weak var btnDomestica: UIButton!
        
        @IBOutlet weak var btnEscola: UIButton!
        
        @IBOutlet weak var btnOutrasCategorias: UIButton!
        
        @IBOutlet weak var btnCadastrarTarefa: UIButton!
        
        var alert: Alert?
        
        override func viewDidLoad() {
            super.viewDidLoad()
            alert = Alert(controller: self)
            descricaoTarefasTextField.contentVerticalAlignment = .top
            
            btnImportante.layer.cornerRadius = 8
            btnImportante.layer.borderWidth = 2
            btnImportante.layer.borderColor = UIColor.cyan.cgColor
            btnImportante.addTarget(self, action: #selector(tappedBtnImportante), for: .touchUpInside)
            
            btnComum.layer.cornerRadius = 8
            btnComum.layer.borderWidth = 2
            btnComum.layer.borderColor = UIColor.cyan.cgColor
            btnComum.addTarget(self, action: #selector(tappedBtnComum), for: .touchUpInside)
            
            btnEscolherData.isUserInteractionEnabled = false
            btnEscolherHorario.isUserInteractionEnabled = false
            
            dataView.layer.cornerRadius = 8
            dataView.layer.borderWidth = 2
            dataView.layer.borderColor = UIColor.cyan.cgColor
            
            horarioView.layer.cornerRadius = 8
            horarioView.layer.borderWidth = 2
            horarioView.layer.borderColor = UIColor.cyan.cgColor
            
            dataPickerData.backgroundColor = .systemCyan
            
            dataPickerHora.backgroundColor = .systemCyan
            
            
            btnAlimentacao.layer.cornerRadius = 8
            btnAlimentacao.addTarget(self, action: #selector(tappedBtnAlimentacao), for: .touchUpInside)
            
            btnSaude.layer.cornerRadius = 8
            btnSaude.addTarget(self, action: #selector(tappedBtnSaude), for: .touchUpInside)
            
            btnEsportes.layer.cornerRadius = 8
            btnEsportes.addTarget(self, action: #selector(tappedBtnEsportes), for: .touchUpInside)
            
            btnTrabalho.layer.cornerRadius = 8
            btnTrabalho.addTarget(self, action: #selector(tappedBtnTrabalho), for: .touchUpInside)
            
            btnDomestica.layer.cornerRadius = 8
            btnDomestica.addTarget(self, action: #selector(tappedBtnDomestica), for: .touchUpInside)
            
            btnEscola.layer.cornerRadius = 8
            btnEscola.addTarget(self, action: #selector(tappedBtnEscola), for: .touchUpInside)
            
            btnOutrasCategorias.layer.cornerRadius = 8
            btnOutrasCategorias.addTarget(self, action: #selector(tappedOutrasCategorias), for: .touchUpInside)
            
            btnCadastrarTarefa.layer.cornerRadius = 8
            
            //Apagar todos os itens do userDefaults
            //let defaults = UserDefaults.standard
            //defaults.removeObject(forKey: "tasks")
        }
        
        var categoria: String = ""
        var prioridade: String = ""
        
        var atualizar = [String]()
        func atualizaCadastro(){
            if let data = UserDefaults.standard.array(forKey: "tasks") as? [String]{
                atualizar = data
            }
        }
        
        @IBAction func tappedCadatrarTarefa(_ sender: Any) {
            
            if tituloTarefaTextField.text == "" {
                self.alert?.alert(title: "Atenção", message: "Cadastre um título para sua tarefa")
            }else if dataSelecionada == nil {
                self.alert?.alert(title: "Atenção", message: "Escolha uma data para sua tarefa")
            }else if horaSelecionada == nil {
                self.alert?.alert(title: "Atenção", message: "Escolha um horário para sua tarefa")
            }else{
                
                let task = ["titulo": tituloTarefaTextField.text as Any,
                            "descricao": descricaoTarefasTextField.text as Any,
                            "prioridade": prioridade,
                            "data": dataSelecionada as Any,
                            "horario": horaSelecionada as Any,
                            "categoria": categoria
                ] as [String : Any]
                
                var tasks = UserDefaults.standard.array(forKey: "tasks") as? [[String : Any]] ?? []
                tasks.append(task)
                UserDefaults.standard.set(tasks, forKey: "tasks")
                UserDefaults.standard.synchronize()
                
               atualizaCadastro()
                delegate?.updateTable()
                self.navigationController?.popViewController(animated: true)
            }
        }
       
        
        @objc func tappedBtnImportante(){
            prioridade = "Importante"
            btnImportante.backgroundColor = .systemCyan
            btnImportante.tintColor = .black
            btnComum.backgroundColor = nil
            btnComum.tintColor = .systemCyan
        }
        
        @objc func tappedBtnComum(){
            prioridade = "Comum"
            btnComum.backgroundColor = .systemCyan
            btnComum.tintColor = .black
            btnImportante.backgroundColor = nil
            btnImportante.tintColor = .systemCyan
        }

        var dataSelecionada: String?
        
        @IBAction func tappedData(_ sender: UIDatePicker) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyy"
            dataSelecionada = dateFormatter.string(from: sender.date)
        }
        
        var horaSelecionada: String?
        @IBAction func tappedHorario(_ sender: UIDatePicker) {
            let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "HH:mm"
                horaSelecionada = dateFormatter.string(from: sender.date)
        }
        
        @objc func tappedBtnAlimentacao(){
            categoria = "Alimentação"
            btnAlimentacao.backgroundColor = nil
            btnAlimentacao.layer.borderWidth = 2
            btnAlimentacao.layer.borderColor = UIColor.white.cgColor
            
            btnSaude.backgroundColor = .systemGreen
            btnSaude.layer.borderWidth = 0
            btnEsportes.backgroundColor = .systemOrange
            btnEsportes.layer.borderWidth = 0
            btnTrabalho.backgroundColor = .systemRed
            btnTrabalho.layer.borderWidth = 0
            btnDomestica.backgroundColor = .systemPurple
            btnDomestica.layer.borderWidth = 0
            btnEscola.backgroundColor = .systemBlue
            btnEscola.layer.borderWidth = 0
            btnOutrasCategorias.backgroundColor = .systemPink
            btnOutrasCategorias.layer.borderWidth = 0
        }
      
        @objc func tappedBtnSaude(){
            categoria = "Saúde"
            btnSaude.backgroundColor = nil
            btnSaude.layer.borderWidth = 2
            btnSaude.layer.borderColor = UIColor.white.cgColor
            
            btnAlimentacao.backgroundColor = .systemYellow
            btnAlimentacao.layer.borderWidth = 0
            btnEsportes.backgroundColor = .systemOrange
            btnEsportes.layer.borderWidth = 0
            btnTrabalho.backgroundColor = .systemRed
            btnTrabalho.layer.borderWidth = 0
            btnDomestica.backgroundColor = .systemPurple
            btnDomestica.layer.borderWidth = 0
            btnEscola.backgroundColor = .systemBlue
            btnEscola.layer.borderWidth = 0
            btnOutrasCategorias.backgroundColor = .systemPink
            btnOutrasCategorias.layer.borderWidth = 0
        }
        @objc func tappedBtnEsportes(){
            categoria = "Esportes"
            btnEsportes.backgroundColor = nil
            btnEsportes.layer.borderWidth = 2
            btnEsportes.layer.borderColor = UIColor.white.cgColor
            
            btnAlimentacao.backgroundColor = .systemYellow
            btnAlimentacao.layer.borderWidth = 0
            btnSaude.backgroundColor = .systemGreen
            btnSaude.layer.borderWidth = 0
            btnTrabalho.backgroundColor = .systemRed
            btnTrabalho.layer.borderWidth = 0
            btnDomestica.backgroundColor = .systemPurple
            btnDomestica.layer.borderWidth = 0
            btnEscola.backgroundColor = .systemBlue
            btnEscola.layer.borderWidth = 0
            btnOutrasCategorias.backgroundColor = .systemPink
            btnOutrasCategorias.layer.borderWidth = 0
        }
        @objc func tappedBtnTrabalho(){
            categoria = "Trabalho"
            btnTrabalho.backgroundColor = nil
            btnTrabalho.layer.borderWidth = 2
            btnTrabalho.layer.borderColor = UIColor.white.cgColor
            
            btnAlimentacao.backgroundColor = .systemYellow
            btnAlimentacao.layer.borderWidth = 0
            btnSaude.backgroundColor = .systemGreen
            btnSaude.layer.borderWidth = 0
            btnEsportes.backgroundColor = .systemOrange
            btnEsportes.layer.borderWidth = 0
            btnDomestica.backgroundColor = .systemPurple
            btnDomestica.layer.borderWidth = 0
            btnEscola.backgroundColor = .systemBlue
            btnEscola.layer.borderWidth = 0
            btnOutrasCategorias.backgroundColor = .systemPink
            btnOutrasCategorias.layer.borderWidth = 0
        }
        @objc func tappedBtnDomestica(){
            categoria = "Doméstica"
            btnDomestica.backgroundColor = nil
            btnDomestica.layer.borderWidth = 2
            btnDomestica.layer.borderColor = UIColor.white.cgColor
            
            btnAlimentacao.backgroundColor = .systemYellow
            btnAlimentacao.layer.borderWidth = 0
            btnSaude.backgroundColor = .systemGreen
            btnSaude.layer.borderWidth = 0
            btnEsportes.backgroundColor = .systemOrange
            btnEsportes.layer.borderWidth = 0
            btnTrabalho.backgroundColor = .systemRed
            btnTrabalho.layer.borderWidth = 0
            btnEscola.backgroundColor = .systemBlue
            btnEscola.layer.borderWidth = 0
            btnOutrasCategorias.backgroundColor = .systemPink
            btnOutrasCategorias.layer.borderWidth = 0
        }
        @objc func tappedBtnEscola(){
            categoria = "Escola"
            btnEscola.backgroundColor = nil
            btnEscola.layer.borderWidth = 2
            btnEscola.layer.borderColor = UIColor.white.cgColor
            
            btnAlimentacao.backgroundColor = .systemYellow
            btnAlimentacao.layer.borderWidth = 0
            btnSaude.backgroundColor = .systemGreen
            btnSaude.layer.borderWidth = 0
            btnEsportes.backgroundColor = .systemOrange
            btnEsportes.layer.borderWidth = 0
            btnTrabalho.backgroundColor = .systemRed
            btnTrabalho.layer.borderWidth = 0
            btnDomestica.backgroundColor = .systemPurple
            btnDomestica.layer.borderWidth = 0
            btnOutrasCategorias.backgroundColor = .systemPink
            btnOutrasCategorias.layer.borderWidth = 0
        }
        @objc func tappedOutrasCategorias(){
            categoria = "Outras"
            btnOutrasCategorias.backgroundColor = nil
            btnOutrasCategorias.layer.borderWidth = 2
            btnOutrasCategorias.layer.borderColor = UIColor.white.cgColor
            
            btnAlimentacao.backgroundColor = .systemYellow
            btnAlimentacao.layer.borderWidth = 0
            btnSaude.backgroundColor = .systemGreen
            btnSaude.layer.borderWidth = 0
            btnEsportes.backgroundColor = .systemOrange
            btnEsportes.layer.borderWidth = 0
            btnTrabalho.backgroundColor = .systemRed
            btnTrabalho.layer.borderWidth = 0
            btnDomestica.backgroundColor = .systemPurple
            btnDomestica.layer.borderWidth = 0
            btnEscola.backgroundColor = .systemBlue
            btnEscola.layer.borderWidth = 0
        }
    }
