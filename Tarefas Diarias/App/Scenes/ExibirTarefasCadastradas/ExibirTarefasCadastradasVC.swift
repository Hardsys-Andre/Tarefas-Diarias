//
//  ExibirTarefasCadastradasVC.swift
//  Tarefas Diarias
//
//  Created by user226298 on 2/10/23.
//

import UIKit

class ExibirTarefasCadastradasVC: UIViewController {
    
    @IBOutlet weak var backButtonImage: UIImageView!
    
    
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var tituloTarefa: UITextField!
    @IBOutlet weak var descricaoTarefa: UITextView!
    @IBOutlet weak var prioridadeTarefa: UITextField!
    @IBOutlet weak var dataTarefa: UITextField!
    @IBOutlet weak var horarioTarefa: UITextField!
    @IBOutlet weak var categoriaTarefa: UITextField!
    @IBOutlet weak var tempoSituacao: UILabel!
    @IBOutlet weak var tempoTemperatura: UILabel!
    @IBOutlet weak var cidadeTempo: UILabel!
    
    var taskTitle: String?
    
    var previsaoDoTempo = PrevisaoDoTempo()
  
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tappedBackButton))
        backButtonImage.isUserInteractionEnabled = true
        backButtonImage.addGestureRecognizer(gesture)
       
        previsaoDoTempo.getPrevisao{ temperatura, condicao, cidade, icon in
            DispatchQueue.main.async {
                           self.tempoTemperatura.text = "\(temperatura ?? 0.0)°C"
                           self.tempoSituacao.text = condicao
                           self.cidadeTempo.text = cidade
                
                // Converta o valor da chave "icon" em uma URL
                        let iconUrl = URL(string: "https://openweathermap.org/img/w/\(icon ?? "").png")!

                        // Carregue a imagem usando a URL
                        let task = URLSession.shared.dataTask(with: iconUrl) { (data, response, error) in
                            if let data = data {
                                // Crie uma imagem a partir dos dados baixados
                                let image = UIImage(data: data)

                                // Atualize a imagem da UIImageView na thread principal
                                DispatchQueue.main.async {
                                    self.iconImage.image = image
                                }
                            }
                        }
                        task.resume()
                    
                       }
        }
        descricaoTarefa.layer.cornerRadius = 6
        
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
    @objc func tappedBackButton(){
        navigationController?.popViewController(animated: true)
    }
}
