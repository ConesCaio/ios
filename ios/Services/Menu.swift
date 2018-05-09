//
//  Menu.swift
//  ios
//
//  Created by Caio Cones on 08/05/2018.
//  Copyright © 2018 Easy Food Corporation. All rights reserved.
//

import Foundation

class Menu {
    var uid: String?
    var stauts: Bool?
    var name: String?
    var category: [Category] = []
}

class Category {
    var name: String?
    var item: [Item] = []
}

class Item {
    var desciption: String?
    var name: String?
    var price: String?
}
