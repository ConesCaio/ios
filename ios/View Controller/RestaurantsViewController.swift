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
    let cellIdentifier = "CellIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        RestaurantService().getRestaurants { (documents, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                self.restaurants = documents!
                self.restaurantsTableView.reloadData()
            }
            print(self.restaurants)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //unico lugar que foi possível fazer essa verificação
        self.login()
    }
    
    func login() {
        if Auth.auth().currentUser == nil {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "loginVC")
            self.present(controller, animated: true, completion: nil)
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
        
        // Fetch Fruit
        let restaurant = self.restaurants[indexPath.row]
        
        // Configure Cell
        cell.textLabel?.text = restaurant.name
        
        return cell
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
