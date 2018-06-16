//
//  NewOrderViViewController.swift
//  ios
//
//  Created by Caio Cones on 27/05/2018.
//  Copyright © 2018 Easy Food Corporation. All rights reserved.
//

import UIKit
import Firebase

class AllOrderCell: UITableViewCell {
    @IBOutlet weak var tokenLabel: UILabel!
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var deliveredLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

class AllOrdersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var allOrdersTableView: UITableView!

    var orders: [Order] = []
    
    override func viewDidLoad() {
        self.getOrderFromFirebase()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.getOrderFromFirebase()
        
        let backgroundImage = UIImage(named: "background")
        let imageView = UIImageView(image: backgroundImage)
        self.allOrdersTableView.backgroundView = imageView
    }
    
    func getOrderFromFirebase() {
        let userRefPath = UserDefaults.standard.string(forKey: "referencePath")
        OrderService().getOrders(withUserRefencePath: userRefPath) { (orderArr, error) in
            if let error = error {
                // error message
                self.showAlert(title: "ERRO", message: "Não foi possível baixar os pedidos anteriores, tente novamente!")
                print(error.localizedDescription)
            } else {
                self.orders = orderArr!
                self.orders.sort(by: { $0.createdAt! > $1.createdAt! })
                self.allOrdersTableView.reloadData()
            }
        }
    }
    
    // MARK: Data Source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AllOrdersCellIdentifier", for: indexPath) as! AllOrderCell

        // Configure Cell
        cell.tokenLabel.text = self.orders[indexPath.row].token
        cell.restaurantNameLabel.text = self.orders[indexPath.row].restaurantName
        
        if self.orders[indexPath.row].delivered! {
            cell.deliveredLabel.text = "Entregue"
            cell.deliveredLabel.textColor = UIColor.blue
        } else {
            cell.deliveredLabel.text = "Aguardando"
            cell.deliveredLabel.textColor = UIColor.red
        }
        
        let dateFormatter = DateFormatter()
        let date = self.orders[indexPath.row].createdAt
        dateFormatter.locale = Locale(identifier: "pt_BR")
        dateFormatter.setLocalizedDateFormatFromTemplate("dd-MM-yyy HH:mm") // set template after setting locale
        
        
        cell.createdAtLabel.text = dateFormatter.string(from: date!)
        
        
        cell.backgroundColor = UIColor.clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //self.performSegue(withIdentifier: "RestaurantsToCategories", sender: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 115
    }
    
    // MARK: ALERT
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
}
