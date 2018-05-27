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
        let email = (Auth.auth().currentUser?.email) ?? ""
        
        let userRef = db.collection("users").document(email)
        userRef.getDocument { (document, error) in
            if let error = error {
                completion(nil, error)
            } else {
                let user = User(withValues: (document?.data())!, id: (document?.documentID)!, and: (document?.reference)!)
                //Set as User Defaults
                UserDefaults.standard.set(user.name, forKey: "name")
                UserDefaults.standard.set(user.email, forKey: "email")
                UserDefaults.standard.set(user.reference?.path, forKey: "referencePath")
                UserDefaults.standard.set(user.profile, forKey: "profile")
                UserDefaults.standard.synchronize()
                
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
        UserDefaults.standard.removeObject(forKey: "name")
        UserDefaults.standard.removeObject(forKey: "email")
        UserDefaults.standard.removeObject(forKey: "reference")
        UserDefaults.standard.removeObject(forKey: "profile")
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
