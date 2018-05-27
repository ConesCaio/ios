//
//  LoginViewController.swift
//  ios
//
//  Created by Caio Cones on 30/04/2018.
//  Copyright © 2018 Easy Food Corporation. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func didTapLogin(_ sender: Any) {
        if let email = self.emailTextField.text, let password = self.passwordTextField.text {
            UserService().login(email: email, password: password) { (error) in
                if let error = error {
                    print(error.localizedDescription)
                    // GUI: mostrar pop-up de erro de acordo com ele
                } else {
                    UserService().currentUser(completion: { (user, error) in
                        //set UserDefaults
                    })
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
    }

}
