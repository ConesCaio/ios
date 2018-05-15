//
//  ItemViewController.swift
//  
//
//  Created by Caio Cones on 14/05/2018.
//

import UIKit
import Firebase

class ItemViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var item = Item()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = item.name
        priceLabel.text = item.price
        descriptionLabel.text = item.description
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func order(_ sender: Any) {
        
        
        
        
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