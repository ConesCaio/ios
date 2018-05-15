//
//  ItensViewController.swift
//  ios
//
//  Created by Caio Cones on 12/05/2018.
//  Copyright © 2018 Easy Food Corporation. All rights reserved.
//

import UIKit

class ItensViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var itensTableView: UITableView!
    
    var category = Category()
    var itens: [Item] = []
    let cellIdentifier = "ItensCellIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getItens()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getItens() {
        ItemService().getItens(categoryReference: self.category.reference!) { (documents, error) in
            if let error = error {
                print(error)
            } else {
                self.itens = documents!
                self.itensTableView.reloadData()
            }
        }
    }
    
    // MARK: - Data Source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.itens.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        // Configure Cell
        cell.textLabel?.text = itens[indexPath.row].name
        
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
