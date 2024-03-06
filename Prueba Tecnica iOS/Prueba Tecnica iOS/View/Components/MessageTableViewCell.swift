//
//  MessageTableViewCell.swift
//  Prueba Tecnica iOS
//
//  Created by Etwan on 24/02/24.
//

import UIKit

class MessageTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    var mensaje: Topics?{
        didSet{
            guard let mensaje else { return }
            setup(mensaje)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setup(_ message: Topics){
        title.text = mensaje?.messageId ?? ""
    }
}
