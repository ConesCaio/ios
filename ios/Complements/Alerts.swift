//
//  Alerts.swift
//  ios
//
//  Created by Caio Cones on 04/06/2018.
//  Copyright © 2018 Easy Food Corporation. All rights reserved.
//

import Foundation
import UIKit

class Alert: UIViewController {
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}
