//
//  HomeViewController.swift
//  LoginKit
//
//  Created by Mickael on 26/09/2018.
//  Copyright © 2018 Mickael. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {

    var loginViewController: LoginViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Auth.auth().addStateDidChangeListener() { auth, user in
            if user != nil {
                //self.performSegue(withIdentifier: "", sender: nil)
                print("connected")
            } else {
                let loginViewController = LoginViewController()
                print("notConnected")
                self.navigationController?.pushViewController(loginViewController, animated: true)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    @IBAction func signout(_ sender: Any) {
        do {
            try Auth.auth().signOut()
        } catch let signoutError as NSError {
            print ("Error signing out: %@", signoutError)
        }
        
    }
}
