//
//  ConversationViewController.swift
//  Prueba Tecnica iOS
//
//  Created by Etwan on 24/02/24.
//

import UIKit

class ConversationViewController: UIViewController {

    @IBOutlet weak var titulo: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.titulo.text = title
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.goBack()
    }
}
