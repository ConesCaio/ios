//
//  PreOrderViewController.swift
//  ios
//
//  Created by Caio Cones on 19/05/2018.
//  Copyright © 2018 Easy Food Corporation. All rights reserved.
//

import UIKit
import Firebase

class PreOrderCell: UITableViewCell {
    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var observationsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

class PreOrderViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var preOrderTableView: UITableView!
    
    @IBOutlet weak var totalLabel: UILabel!
    
    var order = Order()
    
    override func viewDidLoad() {
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.totalLabel.text = String(Singleton.sharedInstance.getTotal())
        self.order = Singleton.sharedInstance.getOrder()
        self.preOrderTableView.reloadData()
    }
    
    @IBAction func cancelOrder(_ sender: Any) {
        self.dismissPreOrderView()
    }
    
    @IBAction func sendOrder(_ sender: Any) {
        
//        Singleton.sharedInstance.order.createdAt = Date()
//        Singleton.sharedInstance.order.delivered = false
        
        OrderService().sendOrder(order: Singleton.sharedInstance.getOrder()) { (error) in
            if let error = error {
                //MOSTRAR MENSAGEM DE ERRO
                print(error.localizedDescription)
            } else {
                self.dismissPreOrderView()
            }
        }
    }
    
    func dismissPreOrderView() {
        //Gambriarra
        self.tabBarController?.selectedIndex = 0
        self.tabBarController?.selectedIndex = 1
    }
    
    // MARK: Data Source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.order.orderItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PreOrderCellIdentifier", for: indexPath) as! PreOrderCell
        
        let orderItem = self.order.orderItem[indexPath.row]
        cell.itemLabel.text = orderItem.menuItem?.name
        cell.observationsLabel.text = orderItem.observation
        
        
        // Configure Cell
        //cell.textLabel?.text = self.order.orderItem[indexPath.row].menuItem?.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //self.performSegue(withIdentifier: "RestaurantsToCategories", sender: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}
