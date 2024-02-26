//
//  ConversacionesViewModel.swift
//  Prueba Tecnica iOS
//
//  Created by Etwan on 24/02/24.
//

import Foundation
import FirebaseFirestore

class ConversacionesViewModel {
    private let db = Firestore.firestore().collection("Messages")
    private (set) var message = [Message]()
    
    var numberOfMessage: Int{
        return message.count
    }
    
    func message(atIndexPath indexPath: IndexPath) -> Message {
        return message[indexPath.row]
    }
    
    func fetchMessages(successCallback: @escaping(() -> Void)){
        db.addSnapshotListener { querySnapshot, error in
            guard let documents = querySnapshot?.documents else { return }
            
            self.message = documents.compactMap { try? $0.data(as: Message.self) }
            successCallback()
        }
    }
}
