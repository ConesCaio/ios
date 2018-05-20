//
//  PreOrderViewController.swift
//  ios
//
//  Created by Caio Cones on 19/05/2018.
//  Copyright © 2018 Easy Food Corporation. All rights reserved.
//

import UIKit
import Firebase


class PreOrderViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var order = Order()
    
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var cartBarItem: UITabBarItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.emptyView = UIView()
        self.teste()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if order.orderItem.count > 0 {
            self.emptyView.isHidden = true
        }
    }
    
    
    
    func teste() {
        if order.orderItem.count > 0 {
            
            self.cartBarItem.badgeValue = String(order.orderItem.count)
        }
    }
    
    // MARK: Data Source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PreOrderCellIdentifier", for: indexPath)
        
        // Configure Cell
        //cell.textLabel?.text = restaurants[indexPath.row].name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //self.performSegue(withIdentifier: "RestaurantsToCategories", sender: indexPath)
    }
    
}
