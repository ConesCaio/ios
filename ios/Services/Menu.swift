//
//  Menu.swift
//  ios
//
//  Created by Caio Cones on 08/05/2018.
//  Copyright © 2018 Easy Food Corporation. All rights reserved.
//

import Foundation
import Firebase

class Menu {
    var id: String?
    var reference: DocumentReference?
    var name: String?
    var status: Bool?
    var categorys: [Category]? = []
    
    init() {
    }
    
    init(withValues values: [String :Any], id documentId: String, and reference: DocumentReference) {
        self.id = documentId
        self.reference = reference
        self.name = values["name"] as? String
        self.status = values["status"] as? Bool
    }
}
