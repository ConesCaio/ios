//
//  CreateUserViewController.swift
//  ios
//
//  Created by Caio Cones on 30/04/2018.
//  Copyright © 2018 Easy Food Corporation. All rights reserved.
//

import UIKit
import Firebase

class CreateUserViewController: UIViewController {

    @IBOutlet weak var newNameField: UITextField!
    @IBOutlet weak var newCPFField: UITextField!
    @IBOutlet weak var newEmailField: UITextField!
    @IBOutlet weak var newCellPhoneField: UITextField!
    @IBOutlet weak var newPasswordField: UITextField!
    
    var user: User!
    
    //@Gui - esse médoto deverá estar dentro da classe user e aqui na view somoente uma instancia de user passar os dados para o user tratar.
    //@Gui - Essa classe funciona assincronamente também. então é necessário tratar
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.user = User.init()
    }
    
    // Criar função de valida os campos de cadastro
    @IBAction func createUser(_ sender: Any) {
        
        if let name = self.newNameField.text, let cpf = self.newCPFField.text, let email = self.newEmailField.text, let password = self.newPasswordField.text, let cellphone = self.newCellPhoneField.text {
            
            self.user.createUser(name: name, email: email, cpf: cpf, phone: cellphone, password: password) { (error) in
                if error == true {
                    //deu erro, não criou o usuário;
                }
                //não deu erro, criou usuário
                //fecha a view
                self.dismiss(animated: true, completion: nil)
            }
        }
    }

}
