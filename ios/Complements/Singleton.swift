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
    
    private var order = Order()
    
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
    
    func getTotal() -> Double {
        var total: Double = 0
        for iten in self.order.orderItem {
            total = total + iten.price!
        }
        return total
    }
    
    func getOrder() -> Order {
        return self.order
    }
    
    func getValues() -> [String :Any] {
        let docData: [String: Any] = [
            "createdAt": self.order.createdAt!,
            "delivered": self.order.delivered!,
            "restaurantName": self.order.restaurantName!,
            "restaurantRef": self.order.restaurantRef!,
            "token": self.order.token!,
            "userName": self.order.userName!,
            "userRef": self.order.userRef!,
            ]
        
        return docData
    }
    
    func addToken(token: String) {
        self.order.token = token
        self.order.createdAt = Date()
        self.order.delivered = false
    }
    
    func getOrderItens() -> [OrderItem] {
        return self.order.orderItem
    }
}

