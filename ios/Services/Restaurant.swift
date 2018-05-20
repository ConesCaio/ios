//
//  swift
//  ios
//
//  Created by Caio Cones on 08/05/2018.
//  Copyright © 2018 Easy Food Corporation. All rights reserved.
//

import Foundation
import Firebase

class Restaurant {
    var id: String?
    var reference: DocumentReference?
    var cnpj: String?
    var email: String?
    var name: String?
    var owner: String?
    var phone: String?
    var menu = Menu()
    
    init() {
    }
    
    init(withValues values: [String :Any], id documentId: String, and reference: DocumentReference) {
        self.id = documentId
        self.reference = reference
        self.cnpj = values["cnpj"] as? String
        self.email = values["email"] as? String
        self.name = values["name"] as? String
        self.owner = values["owner"] as? String
        self.phone = values["phone"] as? String
        self.menu = Menu()
    }
}
