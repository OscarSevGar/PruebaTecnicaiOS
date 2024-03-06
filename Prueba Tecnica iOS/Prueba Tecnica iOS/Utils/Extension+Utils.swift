//
//  Extension+Utils.swift
//  Prueba Tecnica iOS
//
//  Created by Etwan on 24/02/24.
//

import Foundation
import UIKit

extension UIViewController {
    
    func nextView(identifier:String){
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: identifier)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func nextView(identifier:String, titulo: String){
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: identifier)
        vc.title = titulo
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func goBack(){
        navigationController?.popViewController(animated: true)
    }
    
    func goRoot(){
        let vc = navigationController?.viewControllers.filter({$0.isKind(of: InitAppViewController.self)}).first
        navigationController?.popToViewController(vc!, animated: true)
    }
}

extension UIColor {
  static let primaryColor = UIColor(red: 69 / 255, green: 193 / 255, blue: 89 / 255, alpha: 1)
  static let secondaryColor = UIColor(red: 34 / 255, green: 59 / 255, blue: 11 / 255, alpha: 1)
}
