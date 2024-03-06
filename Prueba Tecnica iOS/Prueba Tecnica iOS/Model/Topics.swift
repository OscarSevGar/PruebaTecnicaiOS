//
//  File.swift
//  Prueba Tecnica iOS
//
//  Created by Etwan on 24/02/24.
//

import Foundation
import FirebaseFirestoreSwift

struct Topics: Codable {
    
    @DocumentID var id: String?
    var messageId: String
    var usuario: String
    var message: String
    
    init(id:String? = nil, messageId: String, usuario: String, message: String) {
        self.id = id
        self.messageId = messageId
        self.usuario = usuario
        self.message = message
    }
}
