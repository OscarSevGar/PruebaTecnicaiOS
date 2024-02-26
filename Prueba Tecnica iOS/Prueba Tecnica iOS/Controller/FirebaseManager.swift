//
//  FirebaseManager.swift
//  Prueba Tecnica iOS
//
//  Created by Etwan on 24/02/24.
//

import Foundation
import FirebaseAuth
import UIKit

class FirebaseManager {
    
    public static let shared = FirebaseManager()
    
    func register(correo: String, password: String, completion: @escaping (Result<Bool, Error>) -> Void){
        Auth.auth().createUser(withEmail: correo, password: password) { (result, error) in
            if let result = result, error == nil{
                completion(.success(true))
            }else{
                completion(.failure(LoginError.existingUser as Error))
            }
        }
    }
    
    func login(correo: String, password: String, completion: @escaping (Result<Bool, Error>) -> Void){
            Auth.auth().signIn(withEmail: correo, password: password) { (result, error) in
                if let result = result, error == nil{
                    completion(.success(true))
                }else{
                    print(error?.localizedDescription)
                    completion(.failure(LoginError.loginError as Error))
                }
            }
    }
    
    func logout(view: UIViewController){
        do{
            try Auth.auth().signOut()
            CoreDataManager.shared.removeUserDevice()
            view.goRoot()
        }catch{
            print("ERROR")
        }
    }
}
