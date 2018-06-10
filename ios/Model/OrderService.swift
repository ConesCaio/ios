//
//  OrderService.swift
//  ios
//
//  Created by Caio Cones on 21/05/2018.
//  Copyright © 2018 Easy Food Corporation. All rights reserved.
//

import Foundation
import Firebase

class OrderService {
    
    func getOrders(withUserRefencePath userRefPath: String?, completion: @escaping ([Order]?, Error?) -> ()) {
        let db = Firestore.firestore()
        if userRefPath != nil {
            let userRef = Firestore.firestore().document(userRefPath!)
            let orderRef = db.collection("order").whereField("userRef", isEqualTo: userRef)
            
            orderRef.getDocuments { (documents, error) in
                if let error = error { completion(nil, error) }
                
                var orders: [Order] = []
                for doc in (documents?.documents)! {
                    let order = Order(values: doc.data(), reference: doc.reference, id: doc.documentID)
                    orders.append(order)
                }
                
                completion(orders, nil)
            }
        } else {
            let err = NSError(domain:"", code:400, userInfo:nil)
            completion(nil, err)
        }
    }
    
    // MARK: SEND ORDER
    
    func sendOrder(order: Order, completion: @escaping (Error?) -> ()) {
        
        let db = Firestore.firestore()
        let ref = db.collection("order")
        
        self.getToken(withRestaurantReference: order.restaurantRef!) { (orderToken, error) in
            if let error = error { completion(error) }
            Singleton.sharedInstance.addToken(token: orderToken!)
            let orderCreated = ref.addDocument(data: Singleton.sharedInstance.getValues())
            
            self.updateOrderItem(ref: orderCreated, completion: { (error) in
                if let error = error { completion(error) }
                Singleton.sharedInstance.clearData()
                completion(nil)
            })
        }
    }
    
    private func updateOrderItem(ref: DocumentReference, completion: @escaping (Error?) -> ()) {
        let orderItem: [OrderItem] = Singleton.sharedInstance.getOrderItens()
        for iten in orderItem {
            ref.collection("orderItem").addDocument(data: iten.data())
        }
        completion(nil)
    }
    
    private func getToken (withRestaurantReference ref: DocumentReference, completion: @escaping (String?, Error?) -> ()) {
        ref.getDocument { (document, error) in
            if let error = error {
                completion(nil, error)
            } else {
                //pegou o token
                self.updateToken(withRestaurantID: ref.documentID, completion: { (error2) in
                    if let error2 = error2 {
                        completion(nil, error2)
                    } else {
                        //atualizou o token
                        let token = document?.data()!["token"] as! Int
                        completion(String(token), nil)
                    }
                })
            }
        }
    }
    
    private func updateToken (withRestaurantID restID: String, completion: @escaping (Error?) -> ()) {
        let functions = Functions.functions()
        functions.httpsCallable("updateToken").call(["token": restID]) { (result, error) in
            if let error = error{
                completion(error)
            } else {
                completion(nil)
            }
        }
    }
    
}
