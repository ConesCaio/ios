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
    
    var orderItem: [OrderItem] = []
    
    var createdAt: Date?
    var delivered: Bool? = false
    var restaurantName: String?
    var restaurantRef: DocumentReference?
    var token: String?
    var userName: String?
    var userRef: DocumentReference?
    
    
    init() {
    }
    
    init(values: [String :Any]) {
        self.restaurantRef = values["restaurantRef"] as? DocumentReference
        self.userRef = values["userRef"] as? DocumentReference
        self.delivered = false
    }
    
    init(values: [String :Any], reference: DocumentReference, id: String) {
        self.id = id
        self.reference = reference
        
        self.createdAt  = values["createdAt"] as? Date
        self.delivered = values["delivered"] as? Bool
        self.restaurantName = values["restaurantName"] as? String
        self.restaurantRef = values["restaurantRef"] as? DocumentReference
        self.token = values["token"] as? String
        self.userName = values["userName"] as? String
        self.userRef = values["userRef"] as? DocumentReference
    }
    
    func getValues() -> [String :Any] {
        let docData: [String: Any] = [
            "createdAt": self.createdAt!,
            "delivered": self.delivered!,
            "restaurantName": self.restaurantName!,
            "restaurantRef": self.restaurantRef!,
            "token": self.token!,
            "userName": self.userName!,
            "userRef": self.userRef!,
            ]
        
        return docData
    }
}


