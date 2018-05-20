//
//  OrderViewController.swift
//  ios
//
//  Created by Caio Cones on 19/05/2018.
//  Copyright © 2018 Easy Food Corporation. All rights reserved.
//

import UIKit
import Firebase

class OrderViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var order = Order()
    
    override func viewDidLoad() {
        
    }
    
    // MARK: Data Source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "google", for: indexPath)
        
        // Configure Cell
        //cell.textLabel?.text = restaurants[indexPath.row].name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //self.performSegue(withIdentifier: "RestaurantsToCategories", sender: indexPath)
    }
    
}
