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
    
    func createOrder(withValues order: Order, completion: @escaping (Order?, Error?) -> ()) {
        
        self.structOrder(order: order) { (newOrder, error) in
            if let error = error {
                completion(nil, error)
            } else {
                self.addOrderInCollection(order: newOrder!, completion: { (orderRef, error) in
                    if let error = error {
                        completion(nil, error)
                    } else {
                        newOrder?.id = orderRef?.documentID
                        newOrder?.reference = orderRef
                        completion(newOrder, nil)
                    }
                })
            }
        }
    }
    
    private func addOrderInCollection(order: Order, completion: @escaping (DocumentReference?, Error?) -> ()) {
        let docData: [String: Any] = [
            "restaurant": order.restaurantRef!,
            "token": order.token!,
            "user": order.userRef!,
            ]
        var ref: DocumentReference? = nil
        let db = Firestore.firestore()
        ref = db.collection("order").addDocument(data: docData) { err in
            if let err = err {
                completion(nil, err)
            } else {
                completion(ref, nil)
            }
        }
    }
    
    private func structOrder(order: Order, completion: @escaping (Order?, Error?) -> ()) {
        self.getToken(withRestaurantReference: order.restaurantRef!) { (token, error) in
            if let error = error {
                completion(nil, error)
            } else {
                order.token = token
                completion(order, nil)
            }
        }
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
                        let token = document?.data()!["token"].debugDescription
                        completion(token, nil)
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
