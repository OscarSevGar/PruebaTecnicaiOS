//
//  UserDetailViewModel.swift
//  Prueba Tecnica iOS
//
//  Created by Etwan on 24/02/24.
//

import Foundation
import FirebaseFirestore

class UserDetailViewModel {
    private let db = Firestore.firestore().collection("Users")
    var user = User()
    private var documentID = ""
    
    init() {
        getUser{
            print("Success")
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
}
