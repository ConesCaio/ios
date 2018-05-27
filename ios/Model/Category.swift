//
//  Category.swift
//  ios
//
//  Created by Caio Cones on 13/05/2018.
//  Copyright © 2018 Easy Food Corporation. All rights reserved.
//

import Foundation
import Firebase

class Category {
    var id: String?
    var reference: DocumentReference?
    var name: String?
    var menuItems: [MenuItem] = []
    var selectedMenuItemIndex: Int?
    
    init() {
    }
    
    init(withValues values: [String :Any], id documentId: String, and reference: DocumentReference) {
        self.id = documentId
        self.reference = reference
        self.name = values["name"] as? String
    }
}
