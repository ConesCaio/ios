//
//  CategoryService.swift
//  ios
//
//  Created by Caio Cones on 13/05/2018.
//  Copyright © 2018 Easy Food Corporation. All rights reserved.
//

import Foundation
import Firebase

class CategoryService {
    
    func getCategories(menuReference: DocumentReference, completion: @escaping ([Category]?, Error?) -> ()) {
        var categories: [Category] = []
        menuReference.collection("category").getDocuments { (documents, error) in
            if let error = error {
                completion(nil, error)
            } else {
                for document in (documents?.documents)! {
                    let category = Category(withValues: document.data(), id: document.documentID, and: document.reference)
                    categories.append(category)
                }
                completion(categories, nil)
            }
        }
    }
    
}
