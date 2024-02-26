//
//  UserDetailViewModel.swift
//  Prueba Tecnica iOS
//
//  Created by Etwan on 24/02/24.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage

class UserDetailViewModel {
    private let db = Firestore.firestore().collection("Users")
    private let storage = Storage.storage().reference()
    private var documentID = ""
    var user = User()
    var imgData: Data?
    var img = UIImage()
    
    init() {
        getUser{
            print("Getting user successfully")
            self.descargarImagen()
        }errorCallback: {
            print("Error")
        }
    }
    
    init(user: User = User()) {
        self.user = user
    }
    
    func addUser(successCallback: @escaping(() -> Void), errorCallback: @escaping(() -> Void)){
        do{
            _ = try db.addDocument(from: user){ error in
                if error != nil {
                    errorCallback()
                }else{
                    successCallback()
                }
            }
        }catch let error{
            debugPrint(error)
            errorCallback()
        }
    }
    
    func getUser(successCallback: @escaping(() -> Void), errorCallback: @escaping(() -> Void)){
        db.addSnapshotListener { querySnapshot, error in
            guard let documents = querySnapshot?.documents else { return }
            
            let users = documents.compactMap { try? $0.data(as: User.self) }
            users.forEach { user in
                if case user.correo = CoreDataManager.shared.getUserEmail() {
                    self.db.document(user.id!).getDocument { (documentSnapshot, error) in
                        if let document = documentSnapshot, error == nil{
                            self.documentID = user.id!
                            self.user.nombre = user.nombre
                            self.user.foto = user.foto
                            self.user.correo = user.correo
                            self.descargarImagen()
                            successCallback()
                        }
                    }
                }else{
                    errorCallback()
                }
            }
        }
    }
    
    func updateUser(successCallback: @escaping(() -> Void), errorCallback: @escaping(() -> Void)){
        do {
            storagePhoto()
            try self.db.document(documentID).setData(from: self.user) { error in
                if error != nil {
                    errorCallback()
                }else{
                    successCallback()
                }
            }
        }catch let error {
            errorCallback()
        }
    }
    
    func storagePhoto(){
        storage.child("\(self.user.nombre ?? "foto").jpg").putData(self.imgData!, metadata: nil, completion: {_, error in
            guard error == nil else {
                print("Error al subir imagen \(error?.localizedDescription)")
                return
            }
        })
        
        storage.downloadURL { (url, error) in
            if let err = error {
                print("Error al subir imagen \(err.localizedDescription)")
                return
            }
            guard let url = url else { return }
            self.user.foto = url.absoluteString
        }
    }
    
    func descargarImagen(){
        //actualizar la UI de manera asincrona
        let task = URLSession.shared.dataTask(with: URL(string: self.user.foto!)!, completionHandler: {data, _, error in
            guard let data = data, error == nil else{ return }
            DispatchQueue.main.async {
                self.img = UIImage(data: data)!
            }
        })
        task.resume()
    }
}
