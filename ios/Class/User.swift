//
//  User.swift
//  ios
//
//  Created by Caio Cones on 06/05/2018.
//  Copyright © 2018 Easy Food Corporation. All rights reserved.
//

import Foundation
import Firebase

class User {
    
    //MARK: Properties
    var uid: String?
    var name: String?
    var phone: String?
    var email: String?
    var cpf: String?
    var db: Firestore!
    
    //MARK: Initialization
    init() {
        db = Firestore.firestore()
    }
    
    //MARK: Functions
    func currentUser(completion: @escaping (Bool) -> ()){

        self.email = (Auth.auth().currentUser?.email)!
        let userRef = db.collection("users").document(email!)
        
        userRef.getDocument { (document, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(true)
                
            } else {
                self.name = document!.data()!["name"] as? String
                self.phone = document!.data()!["phone"] as? String
                self.uid = document!.data()!["uid"] as? String
                self.cpf = document!.data()!["cpf"] as? String
                completion(false)
            }
        }
    }
    
    func logout() -> Bool {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
            return true
        }
        return false
    }
    
    func updateUserInformation(name: String, phone: String, cpf: String) {
        //Melhorar aplicando um completion
        let userRef = db.collection("users").document(self.email!)
        userRef.setData([
            "name": name,
            "phone": phone,
            "cpf": cpf
        ]) { (error) in
            if let error = error {
                print(error.localizedDescription)
                //deu erro, tratar
            }
            //deu bom, tratar
        }
        
    }
    
    func login(email: String, password: String, completion: @escaping (Bool) -> ()) {
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if let error = error{
                print(error.localizedDescription)
                completion(true)
            } else {
                // alguma outra ação de sucesso!
                completion(false)
            }
        }
    }
    
    func updatePassword() {
        Auth.auth().sendPasswordReset(withEmail: self.email!) { (error) in
            if let error = error {
                print(error.localizedDescription)
            }
            //deu bom, tratar
        }
    }
    
    func createUser(name: String, email: String, cpf: String, phone:String, password: String, completion: @escaping (Bool) -> ()) {
        
        // Criar o usuário no autenticator do firebase
        Auth.auth().createUser(withEmail: email, password: password) { (newUser, error) in
            if let error = error{
                print(error.localizedDescription)
                completion(true)
                return
            }
            // Adicionando usuário na collection e fecha a view
            self.addUserToCollection(uid: (newUser?.uid)!, name: name, email: email, cpf: cpf, phone: phone, completion: { (error) in
                if error == true{
                    completion(true)
                    return
                } else {
                    //não deu erro
                    completion(false)
                }
            })
        }
    }
    
    private func addUserToCollection(uid: String, name: String, email: String, cpf: String, phone:String, completion: @escaping (Bool) -> ()) {
        
        let docData: [String: Any] = [
            "uid": uid,
            "name": name,
            "email": email,
            "cpf": cpf,
            "phone": phone
        ]
        
        let ref = db.collection("users").document(email)
        ref.setData(docData, completion: { (error) in
            if let error = error {
                print(error.localizedDescription)
                //tratar error
                completion(true)
            } else {
                completion(false)
            }
        })
    }

}
