//
//  InitAppViewController.swift
//  Prueba Tecnica iOS
//
//  Created by Etwan on 24/02/24.
//

import UIKit

class InitAppViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        let isLoggedIn = UserDefaults.standard.bool(forKey: "logged_in")
        if !isLoggedIn{
            self.nextView(identifier: "Login")
        }else{
            self.nextView(identifier: "Home")
        }
    }
}
