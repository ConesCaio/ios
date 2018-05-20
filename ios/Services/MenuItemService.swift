//
//  ItemService.swift
//  ios
//
//  Created by Caio Cones on 13/05/2018.
//  Copyright © 2018 Easy Food Corporation. All rights reserved.
//

import Foundation
import Firebase

class ItemService {
    
    func getItens(categoryReference: DocumentReference, completion: @escaping ([Item]?, Error?) -> ()) {
        categoryReference.collection("item").getDocuments(completion: { (documents, error) in
            if let error = error {
                completion(nil, error)
            } else {
                var itens: [Item] = []
                for document in (documents?.documents)! {
                    let item = Item(withValues: document.data(), id: document.documentID, and: document.reference)
                    itens.append(item)
                }
                completion(itens, nil)
            }
        })
    }
    
}
