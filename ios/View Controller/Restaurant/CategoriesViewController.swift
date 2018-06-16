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
    var categories = [Category]()
    
    let cellIdentifier = "CategoriesCellIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getMenu()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let backgroundImage = UIImage(named: "background")
        let imageView = UIImageView(image: backgroundImage)
        self.categorysTableView.backgroundView = imageView
    }
    
    func getMenu() {
        MenuService().getActiveMenu(restaurantReference: restaurant.reference!) { (menu, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                self.restaurant.menu = menu!
                self.getCategories(withMenu: self.restaurant.menu)
            }
        }
    }
    
    func getCategories(withMenu menu: Menu){
        CategoryService().getCategories(menuReference: menu.reference!, completion: { (categories, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                self.categories = categories!
                self.restaurant.menu.categories = self.categories
                self.categorysTableView.reloadData()
            }
        })
    }
    
    
    // MARK: - Data Source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.textLabel?.text = self.categories[indexPath.row].name
        
        cell.backgroundColor = UIColor.clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "CategoriesToItems", sender: indexPath)
    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is ItemsViewController {
            self.restaurant.menu.selectedCategoryIndex = (sender as! IndexPath).row
            
            let itemsVC = segue.destination as? ItemsViewController
            itemsVC?.restaurant = self.restaurant
            
        }
    }

}
