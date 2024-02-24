//
//  RegisterViewController.swift
//  Prueba Tecnica iOS
//
//  Created by Etwan on 24/02/24.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var nombreTxt: UITextField!
    @IBOutlet weak var correoTxt: UITextField!
    @IBOutlet weak var contraseniatxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func createUser(){
        if let correo = self.correoTxt.text, let password = self.contraseniatxt.text, let nombre = self.nombreTxt.text {
                FirebaseManager.shared.firebaseRegister(correo: correo, password: password) { result in
                    switch result {
                        case .success(let move):
                            if move {
                                let vc = self.storyboard?.instantiateViewController(identifier: "HomeVC") as? HomeViewController
                                vc?.nombre = "Bienvenido \(nombre)"
                                self.navigationController?.pushViewController(vc!, animated: true)
                            }
                        case .failure(let error):
                            print(error)
                    }
                }
        }
    }
    
    @IBAction func registerUser(_ sender: Any) {
            createUser()
    }
    @IBAction func Login(_ sender: Any) {
        let vc = navigationController?.viewControllers.filter({$0.isKind(of: LoginViewController.self)}).first
        navigationController?.popToViewController(vc!, animated: true)
    }
}
