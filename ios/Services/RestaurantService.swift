//
//  RestaurantService.swift
//  ios
//
//  Created by Caio Cones on 09/05/2018.
//  Copyright © 2018 Easy Food Corporation. All rights reserved.
//

import Foundation
import Firebase

class RestaurantService {
    
    func getRestaurants(completion: @escaping ([Restaurant]?, Error?) -> ()) {
        var restaurants: [Restaurant] = []
        let db = Firestore.firestore()
        let userRef = db.collection("restaurants")
        userRef.getDocuments { (documents, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(nil, error)
            } else {
                for document in (documents?.documents)!{
                    let restaurant = Restaurant(withValues: document.data(), id: document.documentID, and: document.reference)
                    restaurants.append(restaurant)
                }
                completion(restaurants, nil)
            }
        }
    }    

}
