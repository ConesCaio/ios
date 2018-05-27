//
//  NewOrderViViewController.swift
//  ios
//
//  Created by Caio Cones on 27/05/2018.
//  Copyright © 2018 Easy Food Corporation. All rights reserved.
//

import UIKit
import Firebase

class AllOrdersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var order = Order()
    
    override func viewDidLoad() {
        //OrderVC
    }
    
    // MARK: Data Source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.order.orderItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AllOrdersCellIdentifier", for: indexPath)
        
        // Configure Cell
        cell.textLabel?.text = self.order.orderItem[indexPath.row].menuItem?.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //self.performSegue(withIdentifier: "RestaurantsToCategories", sender: indexPath)
    }
    
}
