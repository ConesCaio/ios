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
    func currentUser(){

        self.email = (Auth.auth().currentUser?.email)!
        let userRef = db.collection("users").document(email!)
        
        userRef.getDocument { (document, error) in
            if let error = error{
                print(error.localizedDescription)
                //return
            }
            self.name = document!.data()!["name"] as? String
            self.phone = document!.data()!["phone"] as? String
            self.uid = document!.data()!["uid"] as? String
            self.cpf = document!.data()!["cpf"] as? String
        }
    }
    
    func logout() -> Bool {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
            return false
        }
        return true
    }
    
    func updateUserInformation() {
        
        //@Gui - você pode estudar como atualizar as informação de um "user" no firebase e implementar esse método.
        
    }
    
}
