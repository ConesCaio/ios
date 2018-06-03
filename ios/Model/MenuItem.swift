//
//  Item.swift
//  ios
//
//  Created by Caio Cones on 13/05/2018.
//  Copyright © 2018 Easy Food Corporation. All rights reserved.
//

import Foundation
import Firebase

class MenuItem {
    var id: String?
    var reference: DocumentReference?
    
    var name: String?
    var price: Double?
    var description: String?
    
    init() {
    }
    
    init(withValues values: [String :Any], id documentId: String, and reference: DocumentReference) {
        self.id = documentId
        self.reference = reference
        self.description = values["description"] as? String
        self.name = values["name"] as? String
        self.price = values["price"] as? Double
    }
}



