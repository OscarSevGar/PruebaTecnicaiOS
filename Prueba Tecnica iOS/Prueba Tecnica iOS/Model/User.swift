//
//  User.swift
//  Prueba Tecnica iOS
//
//  Created by Etwan on 24/02/24.
//

import Foundation
import FirebaseFirestoreSwift

struct User: Codable {
    
    @DocumentID var id: String?
    var nombre: String?
    var correo: String?
    var foto: String?
    
    init(id:String? = nil, correo:String? = nil, nombre: String? = nil, foto: String? = nil) {
        self.id = id
        self.nombre = nombre
        self.correo = correo
        self.foto = foto
    }
}
