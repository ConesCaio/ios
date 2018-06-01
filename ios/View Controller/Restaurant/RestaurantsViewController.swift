//
//  RestaurantsViewController.swift
//  ios
//
//  Created by Caio Cones on 04/05/2018.
//  Copyright © 2018 Easy Food Corporation. All rights reserved.
//

import UIKit
import Firebase

class RestaurantsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var restaurantsTableView: UITableView!
    
    var restaurants: [Restaurant] = []
    let cellIdentifier = "RestaurantsCellIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getRestaurants()
        teste()
    }
    
    func teste() {
        
        let db = Firestore.firestore()
        let ref = db.collection("users").document("client@easyfood.com.br")
        let ref2 = db.collection("users").document("client2@easyfood.com.br")
        
//        ref.getDocuments { (doc, err) in
//            for docs in (doc?.documents)!
//            {
//                ref2.addDocument(data:(docs.data()))
//
//            }
//
//        }
        
        ref.getDocument { (doc, err) in
            let data = doc?.data()
            ref2.setData(data!)
        }
        
        
        
        
        
        
        
    }
    
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //unico lugar que foi possível fazer essa verificação
        self.login()
    }
    
    //Após realizar configurações corretas sobre segurança, tirar isso!
    func login() {
        if Auth.auth().currentUser == nil {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "loginVC")
            self.present(controller, animated: true, completion: nil)
        }
    }
    
    func getRestaurants() {
        RestaurantService().getRestaurants { (documents, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                self.restaurants = documents!
                self.restaurantsTableView.reloadData()
            }
        }
    }
    
    
    // MARK: Data Source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.restaurants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        // Configure Cell
        cell.textLabel?.text = restaurants[indexPath.row].name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "RestaurantsToCategories", sender: indexPath)
    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is CategoriesViewController {
            let categorysVC = segue.destination as? CategoriesViewController
            categorysVC?.restaurant = self.restaurants[(sender as! IndexPath).row]
        }
    }
 
}
