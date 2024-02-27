//
//  HomeViewController.swift
//  Prueba Tecnica iOS
//
//  Created by Etwan on 24/02/24.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var profilePicture: UIButton!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var conversaciones: UITableView!
    
    let listMessage = ConversacionesViewModel()
    
    var nombre: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if let name = nombre {
            userName.text = name
        }else {
            userName.text = (CoreDataManager.shared.getUserName().contains("Actualiza")) ? CoreDataManager.shared.getUserName() : "Bienvenido \(CoreDataManager.shared.getUserName())"
            
        }
        configureTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        listMessage.fetchMessages {
            self.conversaciones.reloadData()
        }
    }
    
    private func configureTableView(){
        conversaciones.delegate = self
        conversaciones.dataSource = self
        conversaciones.register(UINib(nibName: String(describing: MessageTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: MessageTableViewCell.self))
    }
    
    @IBAction func logoutBtn(_ sender: Any) {
        FirebaseManager.shared.logout(view: self)
    }
    
}

extension HomeViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listMessage.numberOfMessage
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let message = listMessage.message(atIndexPath: indexPath)
        debugPrint(message)
        self.nextView(identifier: "Conversation", titulo: message.messageId)
    }
}

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MessageTableViewCell.self), for: indexPath) as! MessageTableViewCell
        let message = listMessage.message(atIndexPath: indexPath)
        cell.mensaje = message
        return cell
    }
}
