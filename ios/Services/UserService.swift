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
    
    func currentUser(completion: @escaping (Bool) -> ()){
        
        let email = (Auth.auth().currentUser?.email)!
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


}
