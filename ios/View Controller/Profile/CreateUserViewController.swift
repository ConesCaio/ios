//
//  CreateUserViewController.swift
//  ios
//
//  Created by Caio Cones on 30/04/2018.
//  Copyright © 2018 Easy Food Corporation. All rights reserved.
//

import UIKit
import CPF_CNPJ_Validator

class CreateUserViewController: UIViewController {

    @IBOutlet weak var newNameField: UITextField!
    @IBOutlet weak var newCPFField: UITextField!
    @IBOutlet weak var newEmailField: UITextField!
    @IBOutlet weak var newCellPhoneField: UITextField!
    @IBOutlet weak var newPasswordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func createUser(_ sender: Any) {
        if let name = self.newNameField.text, let cpf = self.newCPFField.text, let email = self.newEmailField.text, let password = self.newPasswordField.text, let phone = self.newCellPhoneField.text {
            
            if (name.isEmpty || cpf.isEmpty || email.isEmpty || password.isEmpty || phone.isEmpty)
            {
                self.showAlert(title: "Alerta", message: "Preencha todos os campos para continuar.")
            } else {
                let status = StatusValidator().validate(cpf: cpf)
                if (status == .valid) {
                    if (self.validate(value: phone)){
                        self.createUserFirebase()
                    } else {
                        self.showAlert(title: "Erro", message: "Celular não é válido. Preencha somente os números com DDD.")
                    }
                } else {
                    self.showAlert(title: "Erro", message: "CPF não é válido.")
                }
                
                
            }
        }
    }
    
    func validate(value: String) -> Bool {
        let PHONE_REGEX = "^\\d{2}\\d{5}\\d{4}$"
        
//        let PHONE_REGEX = "^\\([1-9]{2}\\) [2-9][0-9]{3,4}\\-[0-9]{4}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: value)
        return result
    }
    
    func createUserFirebase() {
        if let name = self.newNameField.text, let cpf = self.newCPFField.text, let email = self.newEmailField.text, let password = self.newPasswordField.text, let phone = self.newCellPhoneField.text {
            UserService().createUser(name: name, email: email, cpf: cpf, phone: phone, password: password) { (document, error) in
                if let error = error  {
                    print(error.localizedDescription)
                    
                    if (error.localizedDescription == "The email address is badly formatted.") {
                        self.showAlert(title: "Erro", message: "Email não é válido")
                    }
                    if (error.localizedDescription == "The email address is already in use by another account.") {
                        self.showAlert(title: "Erro", message: "Email já cadastrado")
                    }
                    if (error.localizedDescription == "The password must be 6 characters long or more.") {
                        self.showAlert(title: "Erro", message: "Senha precisa ter pelo menos 6 caracteres")
                    }
                    
                } else {
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
    @IBAction func closeView(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: ALERT
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
}
