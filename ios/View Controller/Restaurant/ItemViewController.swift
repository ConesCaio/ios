//
//  ItemViewController.swift
//  ios
//
//  Created by Caio Cones on 16/05/2018.
//  Copyright © 2018 Easy Food Corporation. All rights reserved.
//

import UIKit
import Firebase

class ItemViewController: UIViewController, UITabBarControllerDelegate {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var quantityStepper: UIStepper!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var observationField: UITextField!
    
    var restaurant = Restaurant()
    var menuItem = MenuItem()
    
    lazy var functions = Functions.functions()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = menuItem.name
        priceLabel.text = menuItem.price?.description
        descriptionLabel.text = menuItem.description
        quantityLabel.text = Int(quantityStepper.value).description
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        quantityLabel.text = Int(sender.value).description
    }
    
    @IBAction func order(_ sender: Any) {
        
        if Singleton.sharedInstance.isEmpty() {
            let order = Order()
            let refPath = UserDefaults.standard.object(forKey: "referencePath") as? String
            let db = Firestore.firestore()
            order.userRef = db.document(refPath!)
            order.restaurantRef = self.restaurant.reference
            order.restaurantName = self.restaurant.name
            order.userName = UserDefaults.standard.object(forKey: "name") as? String
            
            let orderItem = OrderItem()
            orderItem.menuItem = self.menuItem
            orderItem.observation = self.observationField.text
            orderItem.quantity = self.quantityStepper.value
            orderItem.price = (self.quantityStepper.value * self.menuItem.price!)
            
            order.orderItem.append(orderItem)
            
            Singleton.sharedInstance.createOrder(order: order)
            
            self.tabBarController?.selectedIndex = 1
            
        } else {
            
            let auxOrder = Singleton.sharedInstance.getOrder()
            let singRest = auxOrder.restaurantRef
            let itemRest = self.restaurant.reference
            if singRest == itemRest {
                let orderItem = OrderItem()
                orderItem.menuItem = self.menuItem
                orderItem.observation = self.observationField.text
                orderItem.quantity = self.quantityStepper.value
                orderItem.price = (self.quantityStepper.value * self.menuItem.price!)
                
                Singleton.sharedInstance.addItem(item: orderItem)
                
                self.tabBarController?.selectedIndex = 1
                
            } else {
                // error message
                self.showAlert(title: "ERRO", message: "Você só pode adicionar itens ao pedido que sejam do mesmo restaurante.")
            }
        }
    }
    
    func getRestaurants(completion: @escaping ([Restaurant]?, Error?) -> ()) {
        var restaurants: [Restaurant] = []
        let db = Firestore.firestore()
        let userRef = db.collection("restaurants")
        userRef.getDocuments { (documents, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(nil, error)
            } else {
                for document in (documents?.documents)!{
                    let restaurant = Restaurant(withValues: document.data(), id: document.documentID, and: document.reference)
                    restaurants.append(restaurant)
                }
                completion(restaurants, nil)
            }
        }
    }
    
    // MARK: ALERT
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
}
