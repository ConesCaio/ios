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
    
    var db: Firestore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
        
    }
    
    @IBAction func didTapLogin(_ sender: Any) {
        
        //@Gui - esse médoto deverá estar dentro da classe user e aqui na view somoente uma instancia de user passar os dados para o user tratar.
        //@Gui - Essa classe funciona assincronamente também. então é necessário tratar
        if let email = self.emailTextField.text, let password = self.passwordTextField.text {
            Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                if let error = error{
                    print(error.localizedDescription)
                    return
                }
                print("Logado com Sucesso")
                print("Tomar alguma ação")
                
                //self.callViewRestaurants()
                
                self.dismiss(animated: true, completion: nil)
                
            }
        } else {
            print("email/password can't be empty")
        }
    }
    
    func callViewRestaurants() {
        if let tabBarController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tabBarController") as? RestaurantsViewController {
            present(tabBarController, animated: true, completion: nil)
        }
    }
    
    
}
