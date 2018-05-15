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
    var categorys: [Category] = []
    let cellIdentifier = "CategoriesCellIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getCategories()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getCategories() {
        MenuService().getActiveMenu(restaurantReference: restaurant.reference!) { (documents, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                CategoryService().getCategories(menuReference: (documents?.reference)!, completion: { (documents, error) in
                    if let error = error {
                        print(error.localizedDescription)
                    } else {
                        self.categorys = documents!
                        self.categorysTableView.reloadData()
                    }
                })
            }
        }
    }
    
    // MARK: - Data Source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.categorys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        // Configure Cell
        cell.textLabel?.text = self.categorys[indexPath.row].name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "CategoriesToItems", sender: indexPath)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is ItemsViewController {
            let itemsVC = segue.destination as? ItemsViewController
            let i = sender as? IndexPath
            itemsVC?.category = self.categorys[(i?.row)!]
        }
    }

}
