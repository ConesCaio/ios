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
        
        self.updateOrderItem(ref: ref) { (error) in
            if let error = error { completion(error) }
        }
        
        self.getToken(withRestaurantReference: order.restaurantRef!) { (orderToken, error) in
            if let error = error { completion(error) }
            
            Singleton.sharedInstance.addToken(token: orderToken!)
            
            ref.addDocument(data: Singleton.sharedInstance.getValues())
            
        }
        
    }
    
    private func updateOrderItem(ref: CollectionReference, completion: @escaping (Error?) -> ()) {
        
        ref.addSnapshotListener { (docSnapshot, error) in
            if let error = error { completion(error) }
            //add order item
            
            
            
            //clear singleton
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
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    // MARK: DEPRECATED
    private func mergeOrderItem(orders: [Order], completion: @escaping ([Order]?, Error?) -> ()) {
        
        for order in orders {
            self.getOrderItem(reference: order.reference!, completion: { (orderItem, error) in
                if let error = error {
                    completion(nil, error)
                } else {
                    order.orderItem = orderItem!
                }
            })
        }
        
//        var newOrders: [Order] = []
//        for order in orders {
//            self.getOrderItem(reference: order.reference!, completion: { (orderItem, error) in
//                if let error = error {
//                    completion(nil, error)
//                } else {
//                    order.orderItem = orderItem!
//                    newOrders.append(order)
//                }
//            })
//        }
    }
    
    
    
    private func getOrderItem (reference: DocumentReference, completion: @escaping ([OrderItem]?, Error?) -> ()) {
        let orderItemRef = reference.collection("orderItem")
        orderItemRef.getDocuments { (documents, error) in
            if let error = error {
                completion(nil, error)
            } else {
                var orderItem: [OrderItem] = []
                for document in (documents?.documents)! {
                    let item = OrderItem(withValues: document.data(), id: document.documentID, and: document.reference)
                    MenuItemService().getMenuItem(reference: item.menuItemRef!, completion: { (menuItem, error) in
                        if let error = error {
                            completion(nil, error)
                        } else {
                            item.menuItem = menuItem
                        }
                    })
                    orderItem.append(item)
                }
                completion(orderItem, nil)
            }
        }
    }
    
    
    
    // MARK: Create Order
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
    
    
    
    
    
    
}
