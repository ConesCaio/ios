//
//  RestaurantsViewController.swift
//  ios
//
//  Created by Caio Cones on 04/05/2018.
//  Copyright © 2018 Easy Food Corporation. All rights reserved.
//

import UIKit
import Firebase

class RestaurantOrderCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

class RestaurantsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var restaurantsTableView: UITableView!
    
    var restaurants: [Restaurant] = []
    let cellIdentifier = "RestaurantsCellIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getRestaurants()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //unico lugar que foi possível fazer essa verificação
        self.login()
        
        let backgroundImage = UIImage(named: "background")
        let imageView = UIImageView(image: backgroundImage)
        self.restaurantsTableView.backgroundView = imageView
        
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RestaurantOrderCell
        
        // Configure Cell
        cell.nameLabel.text = restaurants[indexPath.row].name
        
        cell.backgroundColor = UIColor.clear
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
