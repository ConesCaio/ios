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
    
    var db: Firestore!
    
    //@Gui - esse médoto deverá estar dentro da classe user e aqui na view somoente uma instancia de user passar os dados para o user tratar.
    //@Gui - Essa classe funciona assincronamente também. então é necessário tratar
    
    override func viewDidLoad() {
        super.viewDidLoad()
        db = Firestore.firestore()
        let settings = db.settings
        settings.areTimestampsInSnapshotsEnabled = true
        db.settings = settings
    }
    
    // Criar função de valida os campos de cadastro
    @IBAction func createUser(_ sender: Any) {
        if let name = self.newNameField.text, let cpf = self.newCPFField.text,
            let email = self.newEmailField.text, let password = self.newPasswordField.text, let cellphone = self.newCellPhoneField.text {
            
            // Criar o usuário no autenticator do firebase
            Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
                if let error = error{
                    print(error.localizedDescription)
                    return
                }
                
                // Adicionando usuário na collection e fecha a view
                self.addUserToCollection(uid: (user?.uid)!, name: name, cpf: cpf, email: email, cellphone: cellphone)
            }
        } else {
            print("name/cpf/email/password can't be empty")
        }
    }
    
    func addUserToCollection(uid: String, name: String, cpf: String, email: String, cellphone: String) {
        var ref: DocumentReference?
        ref = db.collection("users").addDocument(data: [
            "uid": uid,
            "name": name,
            "cpf": cpf,
            "email": email,
            "cellphone": cellphone,
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
                
                // Fecha a view
                self.closeView()
            }
        }
    }
    
    func closeView() {
        // Fecha a view
        self.dismiss(animated: true, completion: nil)
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
