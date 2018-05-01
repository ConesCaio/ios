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

    @IBOutlet weak var newEmailField: UITextField!
    @IBOutlet weak var newPasswordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func createUser(_ sender: Any) {
        if let email = self.newEmailField.text, let password = self.newPasswordField.text {
            Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
                if let error = error{
                    print(error.localizedDescription)
                    return
                }
                print("Usuário criado com sucesso")
                print(email)
                print(password)
                
                self.dismiss(animated: true, completion: {
                    print("dismis da view")
                })
            }
        } else {
            print("email/password can't be empty")
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
