//
//  ProfileViewController.swift
//  Prueba Tecnica iOS
//
//  Created by Etwan on 24/02/24.
//

import UIKit

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var nombreTxt: UITextField!
    
    private var imgData: Data?
    private var img: UIImage?
    private var isCamera = true
    
    private var detail = UserDetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        nombreTxt.text = detail.user.nombre
        detail.descargarImagen{
            self.profilePicture.image = self.detail.img
            print("Getting image successfully")
        }errorCallback: {
            print("Error with image")
        }
    }
    
    @IBAction func saveData(_ sender: Any) {
        if let name = nombreTxt.text {
            updateUser(nombre: name)
        }
    }
    
    func updateUser(nombre: String){
        detail.user.nombre = nombre
        guard let imageData = self.detail.img.jpegData(compressionQuality: 1.0) else{ return }
        self.detail.imgData = imageData
        detail.updateUser{
            self.navigationController?.dismiss(animated: true)
        }errorCallback: {
            print("ERROR")
        }
    }
    
    func selectImage(){
        let message = NSLocalizedString("Selecciona una opción", comment: "")
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Camera", style: .default) { [unowned self] _ in
            isCamera = true
            let picker = UIImagePickerController()
            picker.sourceType = .camera
            picker.delegate = self
            present(picker, animated: true, completion: nil)
        })
        alert.addAction(UIAlertAction(title: "Photo Library", style: .default) { [unowned self] _ in
            isCamera = false
            let picker = UIImagePickerController()
            picker.sourceType = .photoLibrary
            picker.delegate = self
            picker.allowsEditing = true
            present(picker, animated: true, completion: nil)
        })
        present(alert, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        view.endEditing(true)
        picker.dismiss(animated: true, completion: nil)
        if isCamera{
            guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
            self.img = image
        }else {
            guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else { return }
            self.img = image
        }
        
        guard let imageData = self.img!.jpegData(compressionQuality: 1.0) else{ return }
        imgData = imageData
        self.profilePicture.image = self.img
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func editButton(_ sender: Any) {
        selectImage()
    }
}
