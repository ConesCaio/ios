////
////  ViewController.swift
////  ios
////
////  Created by Caio Cones on 25/04/2018.
////  Copyright © 2018 Easy Food Corporation. All rights reserved.
////
//
//import UIKit
//import Firebase
//
//class ViewController: UIViewController {
//
//    var db: Firestore!
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view, typically from a nib.
//        
//        // [START setup]
//        let settings = FirestoreSettings()
//        
//        Firestore.firestore().settings = settings
//        // [END setup]
//        db = Firestore.firestore()
//        
//        addAdaLovelace()
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//
//    
//    
//    
//    private func addAdaLovelace() {
//        fhandle = Auth.auth().addStateDidChangeListener { (auth, user) in
//            // [START_EXCLUDE]
//            self.setTitleDisplay(user)
//            self.tableView.reloadData()
//            // [END_EXCLUDE]
//        }
//    }
//}
//

// MARK: Navegar em collections

//func teste() {
//    
//    let restRef = db.collection("pedidos")
//    restRef.getDocuments { (document, error) in
//        if let err = error {
//            print("deu erro")
//            print(err)
//        } else {
//            for doc in (document?.documents)!{
//                print(doc)
//                //pegar o dados do restaurante
//                
//                
//                
//                self.testedois()
//                
//            }
//        }
//    }
//}
//
//func testedois() {
//    
//    let restRef = db.collection("restaurante").document("saborcaseiro@gmail.com")
//    print(restRef)
//    
//}


// MARK: ALTERAR DADOS DO CADASTRO
//let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
//changeRequest?.displayName = "caio"
//
//changeRequest?.commitChanges(completion: { (error) in
//    if let error = error {
//        print(error.localizedDescription)
//        return
//    }
//    print("atualizou com sucesso")
//})
