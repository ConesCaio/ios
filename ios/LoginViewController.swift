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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func didTapLogin(_ sender: Any) {
        if let email = self.emailTextField.text, let password = self.passwordTextField.text {
            Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                if let error = error{
                    print(error.localizedDescription)
                    return
                }
                print("Logado com Sucesso")
                print("Tomar alguma ação")
            }
        } else {
            print("email/password can't be empty")
        }
    }
    
    
}
