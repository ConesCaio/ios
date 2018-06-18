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
            
            if(validateEmail(email: self.emailTextField.text!) == false){
                self.showAlert(title: "Erro", message: "E-mail inválido.")
            }else{
                UserService().login(email: email, password: password) { (error) in
                    if let error = error {
                        print(error.localizedDescription)
                        if ((error.localizedDescription == "The password is invalid or the user does not have a password.") || password == "") {
                            self.showAlert(title: "Erro", message: "Senha Inválida.")
                        }
                        if (error.localizedDescription == "There is no user record corresponding to this identifier. The user may have been deleted.") {
                            self.showAlert(title: "Erro", message: "Usuário não cadastado.")
                        }
                    }else{
                        UserService().currentUser(completion: { (user, error) in
                            //set UserDefaults
                        })
                        self.dismiss(animated: true, completion: nil)
                    }
                }
            }
        }
    }
    
    // MARK: ALERT
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    
    func validateEmail(email: String) -> Bool{
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }
}
