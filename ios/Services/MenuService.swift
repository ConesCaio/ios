//
//  MenuService.swift
//  ios
//
//  Created by Caio Cones on 13/05/2018.
//  Copyright © 2018 Easy Food Corporation. All rights reserved.
//

import Foundation
import Firebase

class MenuService {
    
    func getActiveMenu(restaurantReference: DocumentReference, completion: @escaping (Menu?, Error?) -> ()) {
        let menuRef = restaurantReference.collection("menu").whereField("status", isEqualTo: true)
        menuRef.getDocuments(completion: { (documents, error) in
            if let error = error {
                completion(nil, error)
            } else {
                var menus: [Menu] = []
                for document in (documents?.documents)! {
                    let menu = Menu(withValues: document.data(), id: document.documentID, and: document.reference)
                    menus.append(menu)
                }
                if menus.count == 1 {
                    completion(menus.first, nil)
                } else {
                    print("MenuService: Existem dois menus ativos para esse restaurante! Corrigir")
                    completion(menus.first, nil)
                }
            }
        })
    }
    
}
