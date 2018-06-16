//
//  ItensViewController.swift
//  ios
//
//  Created by Caio Cones on 12/05/2018.
//  Copyright © 2018 Easy Food Corporation. All rights reserved.
//

import UIKit

class ItemsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var itemsTableView: UITableView!
    
    var restaurant = Restaurant()

    var menuItems: [MenuItem] = []
    let cellIdentifier = "ItemsCellIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getItems()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let backgroundImage = UIImage(named: "background")
        let imageView = UIImageView(image: backgroundImage)
        self.itemsTableView.backgroundView = imageView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getItems() {
        let index = self.restaurant.menu.selectedCategoryIndex
        let category = self.restaurant.menu.categories[index!]
        MenuItemService().getItens(categoryReference: category.reference!) { (menuItems, error) in
            if let error = error {
                print(error)
            } else {
                self.menuItems = menuItems!
                self.restaurant.menu.categories[index!].menuItems = menuItems!
                self.itemsTableView.reloadData()
            }
        }
    }
    
    
    // MARK: - Data Source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.textLabel?.text = menuItems[indexPath.row].name
        
        cell.backgroundColor = UIColor.clear
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "ItemsToItem", sender: indexPath)
    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is ItemViewController {
            let categoryIndex = self.restaurant.menu.selectedCategoryIndex
            self.restaurant.menu.categories[categoryIndex!].selectedMenuItemIndex = (sender as! IndexPath).row
            let itemVC = segue.destination as? ItemViewController
            itemVC?.restaurant = self.restaurant
            itemVC?.menuItem = self.menuItems[(sender as! IndexPath).row]
        }
    }

}
