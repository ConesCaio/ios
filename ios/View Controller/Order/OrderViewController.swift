//
//  OrderViewController.swift
//  ios
//
//  Created by Caio Cones on 19/05/2018.
//  Copyright © 2018 Easy Food Corporation. All rights reserved.
//

import UIKit
import Firebase

class OrderViewController: UIViewController {
    
    @IBOutlet weak var PreOrderView: UIView!
    @IBOutlet weak var AllOrdersView: UIView!
    
    override func viewDidLoad() {
        if Singleton.sharedInstance.isEmpty() {
            self.PreOrderView.isHidden = true
            self.AllOrdersView.isHidden = false
        } else {
            self.PreOrderView.isHidden = false
            self.AllOrdersView.isHidden = true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if Singleton.sharedInstance.isEmpty() {
            self.PreOrderView.isHidden = true
            self.AllOrdersView.isHidden = false
        } else {
            self.PreOrderView.isHidden = false
            self.AllOrdersView.isHidden = true
        }
    }
    
}
