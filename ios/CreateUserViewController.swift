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
    @IBOutlet weak var newPasswordField: UITextField!
    
    var db: Firestore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        db = Firestore.firestore()
        let settings = db.settings
        settings.areTimestampsInSnapshotsEnabled = true
        db.settings = settings
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Criar função de valida os campos de cadastro
    
    @IBAction func createUser(_ sender: Any) {
        if let name = self.newNameField.text, let cpf = self.newCPFField.text, let email = self.newEmailField.text, let password = self.newPasswordField.text {
            Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
                if let error = error{
                    print(error.localizedDescription)
                    return
                }
                // Autenticação do usuário criada com sucesso
                // Adicionando usuário a uma collection
                self.addUserToCollection(uid: (user?.uid)!, name: name, cpf: cpf, email: email)
                
                self.dismiss(animated: true, completion: {
                    // Alguma ação valiosa durante o dismis da view
                })
            }
        } else {
            print("name/cpf/email/password can't be empty")
        }
    }
    
    func addUserToCollection(uid: String, name: String, cpf: String, email: String) {
        var ref: DocumentReference?
        ref = db.collection("users").addDocument(data: [
            "uid": uid,
            "name": name,
            "cpf": cpf,
            "email": email,
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
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
