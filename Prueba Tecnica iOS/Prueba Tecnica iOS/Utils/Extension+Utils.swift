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
