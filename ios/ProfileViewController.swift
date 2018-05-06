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
    @IBOutlet weak var passwordField: UITextField!
    
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Definir as informações do usuário
        self.user = User.init()
        self.user.currentUser()
        
        // Mostra na tela os dados do usuário
        self.userNameField.text = user.name
        self.cpfField.text = user.cpf
        self.emailField.text = user.email
        self.cellphoneField.text = user.phone
        //@Gui - Essas informação não estão sendo mostradas na tela pois o self.user.currentUser() é uma propriedade que roda assicronamente; Coloquei elas no método save, somente para testar e provar isso. Talvez possa resolver isso implementando um retorno na classe "currentUser" que retorne true ou false e gerar uma condição aqui no viewDidLoad. mas não sei se só isso será suficiente.
    }
    
    @IBAction func logout(_ sender: Any) {
        if user.logout() == true {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "loginVC")
            self.present(controller, animated: true, completion: nil)
        }
        
        //@Gui - Depois de realizar o logout, faz-se necessário destruir o user criado para poder não encavalar infomrmação
    }
    
    @IBAction func save(_ sender: Any) {
        
        //@Gui - essa classe deve pegar as infromações do TextField, atribuir ao objeto user e depois chamar user.updateUserInformation;
        
        self.userNameField.text = user.name
        self.cpfField.text = user.cpf
        self.emailField.text = user.email
        self.cellphoneField.text = user.phone
    }
    
}
