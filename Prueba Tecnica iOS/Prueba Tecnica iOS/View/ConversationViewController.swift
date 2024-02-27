//
//  ConversationViewController.swift
//  Prueba Tecnica iOS
//
//  Created by Etwan on 24/02/24.
//

import MapKit
import MessageKit
import UIKit

struct Sender: SenderType{
    var senderId: String
    var displayName: String
}

struct Messages: MessageType {
    var sender: MessageKit.SenderType
    var messageId: String
    var sentDate: Date
    var kind: MessageKit.MessageKind
}

class ConversationViewController: MessagesViewController, MessagesDataSource, MessagesLayoutDelegate, MessagesDisplayDelegate {
    
    let currentUser = Sender(senderId: "self", displayName: "EXI Microsystems")
    let otherUser = Sender(senderId: "other", displayName: "Another User")
    
    var messages = [MessageType]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messages.append(Messages(sender: currentUser, 
                                 messageId: "1",
                                 sentDate: Date().addingTimeInterval(-86400),
                                 kind: .text("Hello World")))
        
        messages.append(Messages(sender: otherUser,
                                 messageId: "2",
                                 sentDate: Date().addingTimeInterval(-76400),
                                 kind: .text("How is it <")))
        
        messages.append(Messages(sender: currentUser,
                                 messageId: "3",
                                 sentDate: Date().addingTimeInterval(-66400),
                                 kind: .text("Here is a long reply, Here is a long reply, Here is a long reply")))
        
        messages.append(Messages(sender: otherUser,
                                 messageId: "4",
                                 sentDate: Date().addingTimeInterval(-56400),
                                 kind: .text("Look it works")))
        
        messages.append(Messages(sender: currentUser,
                                 messageId: "5",
                                 sentDate: Date().addingTimeInterval(-46400),
                                 kind: .text("I love making apps.")))
        
        
        // Do any additional setup after loading the view.
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        
        self.navigationController?.navigationBar.isHidden = false
        self.title = "Chat"
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func currentSender() -> MessageKit.SenderType {
        return currentUser
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessageKit.MessagesCollectionView) -> MessageKit.MessageType {
        return messages[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessageKit.MessagesCollectionView) -> Int {
        return messages.count
    }
}
