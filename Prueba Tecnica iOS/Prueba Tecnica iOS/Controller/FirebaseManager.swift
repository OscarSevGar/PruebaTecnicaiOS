//
//  FirebaseManager.swift
//  Prueba Tecnica iOS
//
//  Created by Etwan on 24/02/24.
//

import Foundation
import FirebaseAuth

class FirebaseManager {
    
    public static let shared = FirebaseManager()
    
    func firebaseRegister(correo: String, password: String, completion: @escaping (Result<Bool, Error>) -> Void){
        Auth.auth().createUser(withEmail: correo, password: password) { (result, error) in
            if let result = result, error == nil{
                completion(.success(true))
            }else{
                completion(.failure(LoginError.userCreate as Error))
            }
        }
    }
    
    func firebaseLogin(correo: String, password: String, completion: @escaping (Result<Bool, Error>) -> Void){
            Auth.auth().signIn(withEmail: correo, password: password) { (result, error) in
                if let result = result, error == nil{
                    completion(.success(true))
                }else{
                    completion(.failure(LoginError.userCreate as Error))
                }
            }
    }
    
}
