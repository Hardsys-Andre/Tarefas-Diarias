//
//  CadastroViewController.swift
//  Tarefas Diarias
//
//  Created by user226298 on 1/31/23.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import Firebase
import FirebaseStorage

class CadastroViewController: UIViewController {
    
    @IBOutlet weak var backButtonImage: UIImageView!
    
    @IBOutlet weak var nomeTexteField: UITextField!
    @IBOutlet weak var sobrenomeTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var senhaTextField: UITextField!
    @IBOutlet weak var btnCadastrar: UIButton!
    @IBOutlet weak var imagemUsuario: UIImageView!
    
    var auth:Auth?
    var alert:Alert?
    var alertPop:AlertPop?
    var imageUrl: String?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.auth = Auth.auth()
        alert = Alert(controller: self)
        alertPop = AlertPop(controller: self)
        
        let gestureBack = UITapGestureRecognizer(target: self, action: #selector(tappedBackButton))
        backButtonImage.isUserInteractionEnabled = true
        backButtonImage.addGestureRecognizer(gestureBack)

        btnCadastrar.layer.cornerRadius = 8
        let gesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        imagemUsuario.isUserInteractionEnabled = true
        imagemUsuario.addGestureRecognizer(gesture)
    }
    
    @objc func tappedBackButton(){
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func imageTapped() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
    }

    @IBAction func tappedCadastras(_ sender: UIButton) {
        let nome: String = self.nomeTexteField.text ?? ""
        let sobrenome: String = self.sobrenomeTextField.text ?? ""
        let email: String = self.emailTextField.text ?? ""
        let senha: String = self.senhaTextField.text ?? ""
       
        let db = Firestore.firestore()
        
        let image = imagemUsuario.image
        let imageData = image?.jpegData(compressionQuality: 0.75)
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"

        let storage = Storage.storage()
        let storageRef = storage.reference()
        
        storageRef.child(email).putData(imageData!, metadata: metadata) { (meta, error) in
            storageRef.child(email).downloadURL { url, errorUrl in
                let userData: [String: Any] = [
                    "nome": nome,
                    "sobrenome": sobrenome,
                    "email": email,
                    "image": url?.absoluteString as Any]
                
                self.auth?.createUser(withEmail: email, password: senha) { authResult, error in
                    if let error = error {
                            if error.localizedDescription.contains("email") && error.localizedDescription.contains("already in use") {
                                self.alert?.alert(title: "Atenção", message: "Este email já está cadastrado")
                                return
                            }
                            self.alert?.alert(title: "Atenção", message: "Falha ao cadastrar")
                            return
                    }else{
                        db.collection("users").addDocument(data: userData) { (error) in
                            if let error = error {
                                self.alert?.alert(title: "Atenção", message: "Erro ao salvar usuário: \(error)")
                            } else {
                                self.nomeTexteField.text = ""
                                self.sobrenomeTextField.text = ""
                                self.emailTextField.text = ""
                                self.senhaTextField.text = ""
                                self.imagemUsuario.image = UIImage(named: "galery_cam")
                                
                                self.alertPop?.alertPop(title: "Parabéns", message: "Cadastro realizado com sucesso")
                            }
                        }
                    }
                }
            }
        }
    }
}
extension CadastroViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    var selectedImageFromPicker: UIImage?

    if let editedImage = info[.editedImage] as? UIImage {
        selectedImageFromPicker = editedImage
    } else if let originalImage = info[.originalImage] as? UIImage {
        selectedImageFromPicker = originalImage
    }
    if let selectedImage = selectedImageFromPicker {
        imagemUsuario.image = selectedImage
    }
    dismiss(animated: true, completion: nil)
  }

  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    dismiss(animated: true, completion: nil)
  }
}
