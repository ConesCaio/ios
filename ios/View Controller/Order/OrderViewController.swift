//
//  OrderViewController.swift
//  ios
//
//  Created by Caio Cones on 19/05/2018.
//  Copyright © 2018 Easy Food Corporation. All rights reserved.
//

import UIKit
import Firebase

class OrderViewController: UIViewController, UITabBarControllerDelegate {
    
    @IBOutlet weak var PreOrderView: UIView!
    @IBOutlet weak var AllOrdersView: UIView!
    
    override func viewDidLoad() {
        self.setCustonView()
        self.setTabBarBadge()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setCustonView()
        self.setTabBarBadge()
    }
    
    func setCustonView() {
        if Singleton.sharedInstance.isEmpty() {
            self.PreOrderView.isHidden = true
            self.AllOrdersView.isHidden = false
        } else {
            self.PreOrderView.isHidden = false
            self.AllOrdersView.isHidden = true
        }
    }
    
    func setTabBarBadge() {
        if Singleton.sharedInstance.isEmpty() {
            self.tabBarItem.badgeValue = nil
        } else {
            let auxOrder = Singleton.sharedInstance.getOrder()
            self.tabBarItem.badgeValue = String(auxOrder.orderItem.count)
        }
    }
    
}
