//
//  profileViewController.swift
//  ios
//
//  Created by Caio Cones on 04/05/2018.
//  Copyright © 2018 Easy Food Corporation. All rights reserved.
//

import UIKit
import Firebase

class profileViewController: UIViewController {

    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var cpfField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var cellphoneField: UITextField!
    
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Definir as informações do usuário
        self.user = User.init()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.user.currentUser { (error) in
            if error == true {
                //@Gui - mostrar mensgame de erro
            }
            self.userNameField.text = self.user.name
            self.cpfField.text = self.user.cpf
            self.emailField.text = self.user.email
            self.cellphoneField.text = self.user.phone
        }
    }
    
    @IBAction func logout(_ sender: Any) {
        
        if user.logout() == false {
            self.user.name = ""
            self.user.email = ""
            self.user.phone = ""
            self.user.cpf = ""
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "loginVC")
            self.present(controller, animated: true, completion: nil)
        }
        
        //@Gui - Depois de realizar o logout, faz-se necessário destruir o user criado para poder não encavalar infomrmação
    }
    
    @IBAction func save(_ sender: Any) {
        self.user.updateUserInformation(name: self.userNameField.text!, phone: cellphoneField.text!, cpf: cpfField.text!)
        //@Gui - não estou tratando o erro de update, se vc quiser aplicar um completion para tratar isso, beleza!
    }
    
    @IBAction func changePassword(_ sender: Any) {
        self.user.updatePassword()
        //Gui - podemos melhorar esse método assim como o updateUserInformation
        //Gui - você pode exibir um alerta falando que um email foi enviando com o link de recuperação de senha
    }
    
}
