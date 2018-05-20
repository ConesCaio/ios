//
//  Order.swift
//  ios
//
//  Created by Caio Cones on 17/05/2018.
//  Copyright © 2018 Easy Food Corporation. All rights reserved.
//

import Foundation
import Firebase

class Order {
    var id: String?
    var reference: DocumentReference?
    var restaurantRef: DocumentReference?
    var userRef: DocumentReference?
    var delivered: Bool?
    var token: String?
    var orderItem: [OrderItem] = []
    
    init() {
    }
    
    init(withValues values: [String :Any], id documentId: String, and reference: DocumentReference) {
        self.id = documentId
        self.reference = reference
        self.restaurantRef = values["restaurantRef"] as? DocumentReference
        self.userRef = values["userRef"] as? DocumentReference
        self.delivered = false
    }
}


