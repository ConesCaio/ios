//
//  CategorysViewController.swift
//  ios
//
//  Created by Caio Cones on 11/05/2018.
//  Copyright © 2018 Easy Food Corporation. All rights reserved.
//

import UIKit

class CategoriesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var categorysTableView: UITableView!
    
    var restaurant = Restaurant()
    let cellIdentifier = "CategoriesCellIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        RestaurantService().getCategorys(restaurant: restaurant) { (documents, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                self.restaurant = documents!
                self.categorysTableView.reloadData()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Data Source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.restaurant.menu.categorys?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        // Fetch Fruit
        let categorys = self.restaurant.menu.categorys![indexPath.row]
        
        // Configure Cell
        cell.textLabel?.text = categorys.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "CategoriesToItens", sender: indexPath)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is ItensViewController {
            let itensVC = segue.destination as? ItensViewController
            let i = sender as? IndexPath
            itensVC?.category = self.restaurant.menu.categorys![(i?.row)!]
        }
    }

}
