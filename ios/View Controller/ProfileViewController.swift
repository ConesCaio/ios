//
//  profileViewController.swift
//  ios
//
//  Created by Caio Cones on 04/05/2018.
//  Copyright © 2018 Easy Food Corporation. All rights reserved.
//

import UIKit

class profileViewController: UIViewController {

    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var cpfField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var cellphoneField: UITextField!
    
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getUserInformation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.getUserInformation()
    }
    
    @IBAction func logout(_ sender: Any) {
        UserService().logout { (error) in
            if let error = error {
                print(error.localizedDescription)
                // Gui: Mostrar mensagem de erro
            } else {
                self.user = nil
                self.login()
            }
        }
    }
    
    @IBAction func save(_ sender: Any) {
        if let name = self.userNameField.text, let email = self.emailField.text, let cpf = self.cpfField.text, let phone = self.cellphoneField.text {
            UserService().updateUserInformation(name: name, email: email, phone: phone, cpf: cpf) { (error) in
                if let error = error {
                    print(error.localizedDescription)
                    // Gui: Mostrar mensagem de erro
                    self.userNameField.text = self.user.name
                    self.cpfField.text = self.user.cpf
                    self.cellphoneField.text = self.user.phone
                } else {
                    self.user.name = self.userNameField.text
                    self.user.cpf = self.cpfField.text
                    self.user.phone = self.cellphoneField.text
                }
            }
        }
    }
    
    @IBAction func changePassword(_ sender: Any) {
        UserService().updatePasswordEmail(email: user.email!) { (error) in
            if let error = error {
                print(error.localizedDescription)
                // Gui: Mostrar mensagem de erro
            } else {
                // Gui: Mostrar mensagem de sucesso "A recuperação de senha foi enviada para seu email"
            }
        }
    }
    
    func login() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "loginVC")
        self.present(controller, animated: true, completion: nil)
    }
    
    func getUserInformation() {
        UserService().currentUser { (document, error) in
            if let error = error {
                print(error.localizedDescription)
                self.login()
            } else {
                self.user = document
                self.userNameField.text = self.user.name
                self.cpfField.text = self.user.cpf
                self.emailField.text = self.user.email
                self.cellphoneField.text = self.user.phone
            }
        }
    }
    
}
