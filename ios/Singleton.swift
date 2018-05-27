//
//  Singleton.swift
//  ios
//
//  Created by Caio Cones on 24/05/2018.
//  Copyright © 2018 Easy Food Corporation. All rights reserved.
//

import UIKit

class Singleton {
    static let sharedInstance = Singleton()
    
    var order = Order()
    
    private init() { }
    
    func createOrder(order: Order) {
        
        if self.isEmpty() {
            self.order = order
        } else {
            self.order.orderItem.append(order.orderItem.first!)
        }
    }
    
    func addItem(item: OrderItem) {
        self.order.orderItem.append(item)
    }
    
    func clearData() {
        self.order.delivered = nil
        self.order.id = nil
        self.order.orderItem.removeAll()
        self.order.reference = nil
        self.order.restaurantRef = nil
        self.order.token = nil
        self.order.userRef = nil
    }
    
    func isEmpty() -> Bool {
        if self.order.restaurantRef == nil && self.order.token == nil {
            return true
        }
        return false
    }
    
    
}

