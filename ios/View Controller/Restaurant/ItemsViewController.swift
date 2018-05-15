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
    
    var category = Category()
    var items: [Item] = []
    let cellIdentifier = "ItemsCellIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getItems()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getItems() {
        ItemService().getItens(categoryReference: self.category.reference!) { (documents, error) in
            if let error = error {
                print(error)
            } else {
                self.items = documents!
                self.itemsTableView.reloadData()
            }
        }
    }
    
    // MARK: - Data Source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        // Configure Cell
        cell.textLabel?.text = items[indexPath.row].name
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "ItemsToItem", sender: indexPath)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is ItemViewController {
            let itemVC = segue.destination as? ItemViewController
            let i = sender as? IndexPath
            itemVC?.item = self.items[(i?.row)!]
        }
    }

}
