//
//  UserService.swift
//  ios
//
//  Created by Caio Cones on 07/05/2018.
//  Copyright © 2018 Easy Food Corporation. All rights reserved.
//

import Foundation
import Firebase

class UserService {
    
    func createUser(name: String, email: String, cpf: String, phone:String, password: String, completion: @escaping (User?, Error?) -> ()) {
        let user = User(name: name, email: email, cpf: cpf, phone: phone, password: password, profile: "user")
        self.createAuthentication(user: user) { (document, error) in
            if let error = error {
                completion(nil, error)
            } else {
                self.addUserInCollection(user: document!, completion: { (error) in
                    if let error = error {
                        completion(nil, error)
                    } else {
                        completion(document, nil)
                    }
                })
            }
        }
    }
    
    private func createAuthentication (user: User, completion: @escaping (User?, Error?) -> ()) {
        Auth.auth().createUser(withEmail: user.email!, password: user.password!) { (document, error) in
            if let error = error{
                completion(nil, error)
            } else {
                user.uid = document?.uid
                completion(user, nil)
            }
        }
    }
    
    private func addUserInCollection(user: User, completion: @escaping (Error?) -> ()) {
        let docData: [String: Any] = [
            "name": user.name!,
            "email": user.email!,
            "cpf": user.cpf!,
            "phone": user.phone!,
            "uid": user.uid!,
            "profile": user.profile!,
        ]
        let db = Firestore.firestore()
        let ref = db.collection("users").document(user.email!)
        ref.setData(docData) { (error) in
            if let error = error {
                completion(error)
            } else {
                completion(nil)
            }
        }
    }
        
    func login(email: String, password: String, completion: @escaping (Error?) -> ()) {
        Auth.auth().signIn(withEmail: email, password: password) { (document, error) in
            if let error = error{
                completion(error)
            } else {
                completion(nil)
            }
        }
    }
    
    func currentUser(completion: @escaping (User?, Error?) -> ()){
        let db = Firestore.firestore()
        let email = (Auth.auth().currentUser?.email)!
        
        let userRef = db.collection("users").document(email)
        userRef.getDocument { (document, error) in
            if let error = error {
                completion(nil, error)
            } else {
                let name = (document!.data()!["name"] as? String)!
                let cpf = (document!.data()!["cpf"] as? String)!
                let phone = (document!.data()!["phone"] as? String)!
                let uid = (document!.data()!["uid"] as? String)!
                let profile = (document!.data()!["profile"] as? String)!
                let user = User(uid: uid, name: name, email: email, cpf: cpf, phone: phone, profile: profile)
                completion(user, nil)
            }
        }
    }
    
    func logout(completion: @escaping (Error?) -> ()) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            //print ("Error signing out: %@", signOutError)
            completion(signOutError)
            return
        }
        completion(nil)
    }
    
    func updateUserInformation(name: String, email: String, phone: String, cpf: String, completion: @escaping (Error?) -> ()) {
        let db = Firestore.firestore()
        let userRef = db.collection("users").document(email)
        let docData: [String: String] = [
            "name": name,
            "phone": phone,
            "cpf": cpf,
        ]
        userRef.updateData(docData) { (error) in
            if let error = error {
                completion(error)
            } else {
                completion(nil)
            }
        }
    }
    
    func updatePasswordEmail(email: String, completion: @escaping (Error?) -> ()) {
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            if let error = error {
                completion(error)
            } else {
                completion(nil)
            }
        }
    }
    
}
