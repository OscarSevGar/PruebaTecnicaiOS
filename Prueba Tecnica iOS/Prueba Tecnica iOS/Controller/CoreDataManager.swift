//
//  CoreDataManager.swift
//  Prueba Tecnica iOS
//
//  Created by Etwan on 24/02/24.
//

import Foundation

class CoreDataManager{
    
    static let shared = CoreDataManager()
    
    let defaults = UserDefaults.standard
    
    func saveUserLogged(email: String, name: String?){
        defaults.set(true, forKey: "logged_in")
        defaults.set(email, forKey: "email")
        defaults.set(name, forKey: "nombre")
    }
    
    func removeUserDevice(){
        defaults.removeObject(forKey: "email")
        defaults.removeObject(forKey: "logged_in")
    }
    
    func getUserName() -> String{
        return defaults.string(forKey: "nombre") ?? "Actualiza tus datos"
    }
    
    func getUserEmail() -> String{
        return defaults.string(forKey: "email") ?? "Actualiza tus datos"
    }
}
