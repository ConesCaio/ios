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
        
        OrderService().sendOrder(order: Singleton.sharedInstance.getOrder()) { (error) in
            if let error = error {
                // error message
                self.showAlert(title: "ERRO", message: "Não foi possível enviar seu pedido, tente novamente!")
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
        
        if self.order.orderItem.count <= 0 { return cell }
        
        let orderItem = self.order.orderItem[indexPath.row]
        cell.itemLabel.text = orderItem.menuItem?.name
        cell.observationsLabel.text = orderItem.observation
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //self.performSegue(withIdentifier: "RestaurantsToCategories", sender: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    // MARK: ALERT
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}
