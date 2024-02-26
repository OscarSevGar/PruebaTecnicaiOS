//
//  UserViewModel.swift
//  Prueba Tecnica iOS
//
//  Created by Etwan on 24/02/24.
//

import Foundation
import FirebaseFirestore

class UserViewModel {
    private let db = Firestore.firestore().collection("Users")
    private (set) var users = [User]()
    
    var numberOfUsers: Int{
        return users.count
    }
    
    func user(atIndexPath indexPath: IndexPath) -> User {
        return users[indexPath.row]
    }
    
    func fetchUsers(successCallback: @escaping(() -> Void)){
        db.addSnapshotListener { querySnapshot, error in
            guard let documents = querySnapshot?.documents else { return }
            
            self.users = documents.compactMap { try? $0.data(as: User.self) }
            successCallback()
        }
    }
}
