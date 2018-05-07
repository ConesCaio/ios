//
//  LoginViewController.swift
//  ios
//
//  Created by Caio Cones on 30/04/2018.
//  Copyright © 2018 Easy Food Corporation. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.user = User.init()
    }
    
    @IBAction func didTapLogin(_ sender: Any) {
        if let email = self.emailTextField.text, let password = self.passwordTextField.text {
            self.user.login(email: email, password: password) { (error) in
                if error == true {
                    print("email ou senha inválido")
                    //@Gui - Mostrar um pop-up
                    return
                }
                self.dismiss(animated: true, completion: nil)
            }
        }
    }

}
