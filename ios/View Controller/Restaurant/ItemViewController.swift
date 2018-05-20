//
//  ItemViewController.swift
//  ios
//
//  Created by Caio Cones on 16/05/2018.
//  Copyright © 2018 Easy Food Corporation. All rights reserved.
//

import UIKit
import Firebase

class ItemViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var quantityStepper: UIStepper!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var observationField: UITextField!
    
    var restaurant = Restaurant()
    var menuItem = MenuItem()
    
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
        
        if Auth.auth().currentUser == nil {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "loginVC")
            self.present(controller, animated: true, completion: nil)
        } else {
            let orderItem = OrderItem()
            orderItem.menuItem = self.menuItem
            orderItem.quantity = quantityStepper.value
            orderItem.price = (quantityStepper.value * menuItem.price!)
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
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.destination is PreOrderViewController {
//            let preOrderVC = segue.destination as? PreOrderViewController
//            preOrderVC?.order.orderItem.append(sender as! OrderItem)
//
//        }
//    }
//
    
}
