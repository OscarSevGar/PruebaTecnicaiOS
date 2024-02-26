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
                FirebaseManager.shared.register(correo: correo, password: password) { result in
                    switch result {
                        case .success(let move):
                            if move {
                                CoreDataManager.shared.saveUserLogged(email: correo, name: nombre)
                                self.saveUser(detailViewModel: UserDetailViewModel(user: User(correo: correo, nombre: nombre)))
                            }
                        case .failure(let error):
                            print(error)
                    }
                }
        }
    }
    
    func saveUser(detailViewModel: UserDetailViewModel){
        detailViewModel.addUser {
            self.nextView(identifier: "Home")
        }errorCallback: {
            debugPrint("ERROR")
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
