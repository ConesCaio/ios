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
            
            let orderItem = OrderItem()
            orderItem.menuItem = self.menuItem
            orderItem.quantity = self.quantityStepper.value
            orderItem.price = (self.quantityStepper.value * self.menuItem.price!)
            
            order.orderItem.append(orderItem)
            
            Singleton.sharedInstance.createOrder(order: order)
            
            self.tabBarController?.selectedIndex = 1
            
//            let mainTabBarController = self.storyboard?.instantiateViewController(withIdentifier: "tabBarController") as! MainTabBarController
//            let vc = mainTabBarController.viewControllers?[1] as! OrderViewController
//            vc.tabBarItem.badgeValue = "1"
//           // vc.order = Singleton.sharedInstance.order
//            mainTabBarController.selectedViewController = vc
//
//            self.present(mainTabBarController, animated: true, completion: nil)
            
        } else {
            let orderItem = OrderItem()
            orderItem.menuItem = self.menuItem
            orderItem.quantity = self.quantityStepper.value
            orderItem.price = (self.quantityStepper.value * self.menuItem.price!)
            
            Singleton.sharedInstance.addItem(item: orderItem)
            
            self.tabBarController?.selectedIndex = 1
            
//            let mainTabBarController = self.storyboard?.instantiateViewController(withIdentifier: "tabBarController") as! MainTabBarController
//            let vc = mainTabBarController.viewControllers?[1] as! OrderViewController
//            vc.tabBarItem.badgeValue = String(Singleton.sharedInstance.order.orderItem.count)
//            //vc.order = Singleton.sharedInstance.order
//            mainTabBarController.selectedViewController = vc
//
//            self.present(mainTabBarController, animated: true, completion: nil)
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
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is OrderViewController {
            let orderVC = segue.destination as? OrderViewController
            let order = sender as! Order
//            if orderVC?.order == nil {
//               orderVC?.order = order
//            } else {
//                orderVC?.order.orderItem.append(order.orderItem.first!)
//            }

        }
    }

    
}
