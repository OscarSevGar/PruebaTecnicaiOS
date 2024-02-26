//
//  ProfileViewController.swift
//  Prueba Tecnica iOS
//
//  Created by Etwan on 24/02/24.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var nombreTxt: UITextField!
    
    var detail = UserDetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        nombreTxt.text = detail.user.nombre
    }
    
    @IBAction func saveData(_ sender: Any) {
        if let name = nombreTxt.text {
            updateUser(nombre: name, pictureURL: "")
        }
    }
    
    func updateUser(nombre: String, pictureURL: String){
        detail.user.nombre = nombre
        detail.user.foto = pictureURL
        
        detail.updateUser{
            self.navigationController?.dismiss(animated: true)
        }errorCallback: {
            print("ERROR")
        }
    }
}
