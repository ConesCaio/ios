//
//  OrderItem.swift
//  ios
//
//  Created by Caio Cones on 17/05/2018.
//  Copyright © 2018 Easy Food Corporation. All rights reserved.
//

import Foundation
import Firebase

class OrderItem {
    var id: String?
    var reference: DocumentReference?
    
    var menuItemRef: DocumentReference?
    var menuItem: MenuItem?
    var observation: String?
    var quantity: Double?
    var price: Double?
    
    init() {
    }
    
    init(withValues values: [String :Any], id documentId: String, and reference: DocumentReference) {
        self.id = documentId
        self.reference = reference
        self.menuItemRef = values["menuItem"] as? DocumentReference
        self.observation = values["observation"] as? String
        self.quantity = values["quantity"] as? Double
        self.price = values["price"] as? Double
    }
    
}
