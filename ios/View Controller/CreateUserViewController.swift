//
//  CreateUserViewController.swift
//  ios
//
//  Created by Caio Cones on 30/04/2018.
//  Copyright © 2018 Easy Food Corporation. All rights reserved.
//

import UIKit

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
            UserService().createUser(name: name, email: email, cpf: cpf, phone: phone, password: password) { (document, error) in
                if let error = error  {
                    print(error.localizedDescription)
                    // GUI: mostrar pop-up de erro de acordo com ele
                } else {
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
    @IBAction func closeView(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
