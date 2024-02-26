//
//  LoginViewController.swift
//  Prueba Tecnica iOS
//
//  Created by Etwan on 24/02/24.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var correoTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func loginUser(){
        if let correo = self.correoTxt.text, let password = self.passwordTxt.text {
                FirebaseManager.shared.login(correo: correo, password: password) { result in
                    switch result {
                        case .success(let move):
                            if move {
                                CoreDataManager.shared.saveUserLogged(email: correo, name: "")
                                self.nextView(identifier: "Home")
                            }
                        case .failure(let error):
                            print(error)
                    }
                }
        }
    }
    @IBAction func loginActionBtn(_ sender: Any) {
        loginUser()
    }
}
