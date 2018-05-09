//
//  User.swift
//  ios
//
//  Created by Caio Cones on 06/05/2018.
//  Copyright © 2018 Easy Food Corporation. All rights reserved.
//

import Foundation

class User {
    
    var uid: String?
    var name: String?
    var phone: String?
    var email: String?
    var cpf: String?
    var password: String?
    var profile: String?
    
    init() {
    }
    
    deinit {
    }
    
    init(uid: String, name: String, email: String, cpf: String, phone: String, profile: String) {
        self.uid = uid
        self.name = name
        self.email = email
        self.cpf = cpf
        self.phone = phone
        self.profile = profile
    }
    
    init(name: String, email: String, cpf: String, phone: String, password: String, profile: String) {
        self.name = name
        self.email = email
        self.cpf = cpf
        self.phone = phone
        self.password = password
        self.profile = profile
    }
    
}
