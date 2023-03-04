//
//  CadastrarTarefasViewController.swift
//  Tarefas Diarias
//
//  Created by user226298 on 2/5/23.
//

import UIKit

class CadastrarTarefasViewController: UIViewController {
    
    @IBOutlet weak var backButtonImage: UIImageView!
    
        @IBOutlet weak var tituloTarefaTextField: UITextField!
        @IBOutlet weak var descricaoTarefaTextView: UITextView!
        @IBOutlet weak var btnImportante: UIButton!
        @IBOutlet weak var btnComum: UIButton!
        @IBOutlet weak var btnEscolherData: UIButton!
        @IBOutlet weak var btnEscolherHorario: UIButton!
        @IBOutlet weak var dataView: UIView!
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
    
    var emailLogado: String?
    var tituloTarefa: String = ""

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
        
    
    override func viewDidLoad() {
            super.viewDidLoad()
            alert = Alert(controller: self)
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tappedBackButton))
        backButtonImage.isUserInteractionEnabled = true
        backButtonImage.addGestureRecognizer(gesture)
                    
            descricaoTarefaTextView.layer.cornerRadius = 8
            
            btnImportante.layer.cornerRadius = 8
            btnImportante.layer.borderWidth = 2
            btnImportante.layer.borderColor = UIColor.cyan.cgColor
            btnImportante.addTarget(self, action: #selector(tappedBtnImportante), for: .touchUpInside)
            
            btnComum.layer.cornerRadius = 8
            btnComum.layer.borderWidth = 2
            btnComum.layer.borderColor = UIColor.cyan.cgColor
            btnComum.addTarget(self, action: #selector(tappedBtnComum), for: .touchUpInside)
            
            //btnEscolherData.isUserInteractionEnabled = false
            //btnEscolherHorario.isUserInteractionEnabled = false
            
            dataView.layer.cornerRadius = 8
            dataView.layer.borderWidth = 2
            dataView.layer.borderColor = UIColor.cyan.cgColor
            
        dataPickerData.backgroundColor = .cyan
            
            dataPickerHora.backgroundColor = .cyan
            
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
            
            //apaga todos os alertas
            //let center2 = UNUserNotificationCenter.current()
            //center2.removeAllPendingNotificationRequests()

        }
    @objc func tappedBackButton(){
        navigationController?.popViewController(animated: true)
    }
        var categoria: String = ""
        var prioridade: String = ""
        
        @IBAction func tappedCadatrarTarefa(_ sender: Any) {
            
            if tituloTarefaTextField.text == "" {
                self.alert?.alert(title: "Atenção", message: "Cadastre um título para sua tarefa")
            }else if dataSelecionada == "" {
                self.alert?.alert(title: "Atenção", message: "Escolha uma data para sua tarefa")
            }else if horaSelecionada == "" {
                self.alert?.alert(title: "Atenção", message: "Escolha um horário para sua tarefa")
            }else{
                let task = ["emailUsuario": emailLogado as Any,
                            "titulo": tituloTarefaTextField.text as Any,
                            "descricao": descricaoTarefaTextView.text as Any,
                            "prioridade": prioridade,
                            "data": dataSelecionada as Any,
                            "horario": horaSelecionada as Any,
                            "categoria": categoria
                ] as [String : Any]
                
                var tasks = UserDefaults.standard.array(forKey: "tasks") as? [[String : Any]] ?? []
                tasks.append(task)
                
                let userDefaults = UserDefaults.standard
                               userDefaults.set(tasks, forKey: "tasks")
                               UserDefaults.standard.synchronize()
                
                // crie um DateFormatter que combina a data e a hora
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
                dateFormatter.timeZone = TimeZone(identifier: "UTC")

                // obtenha as informações de data e hora dos date pickers
                let date = dataPickerData.date
                let time = dataPickerHora.date

                // combine as informações de data e hora em uma única data
                let combinedDate = Calendar.current.date(bySettingHour: Calendar.current.component(.hour, from: time), minute: Calendar.current.component(.minute, from: time), second: 0, of: date)!

                // formate a data combinada em uma string
                let outputString = dateFormatter.string(from: combinedDate)

                var outputDate: Date
                
                if let date = dateFormatter.date(from: outputString) {
                    outputDate = date
                } else {
                    outputDate = Date()
                    print("Erro ao converter a string em uma data")
                }

                let selectedDate = outputDate
                    let taskTitle = tituloTarefaTextField.text ?? ""
                    let taskDescription = descricaoTarefaTextView.text ?? ""
                
                    // Salva a tarefa no seu aplicativo
                    NotificationHelper.shared.scheduleNotification(at: selectedDate, title: taskTitle, body: taskDescription)

                self.navigationController?.popViewController(animated: true)
            }
        }
        @objc func tappedBtnImportante(){
            prioridade = "Importante"
            btnImportante.backgroundColor = .cyan
            btnImportante.tintColor = .black
            btnComum.backgroundColor = nil
            btnComum.tintColor = .cyan
        }
        @objc func tappedBtnComum(){
            prioridade = "Comum"
            btnComum.backgroundColor = .cyan
            btnComum.tintColor = .black
            btnImportante.backgroundColor = nil
            btnImportante.tintColor = .cyan
        }
    var dataSelecionada: String = ""
        @IBAction func tappedData(_ sender: UIDatePicker) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            dataSelecionada = dateFormatter.string(from: sender.date)
        }
        var horaSelecionada: String = ""
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
