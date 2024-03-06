//
//  Messages.swift
//  Prueba Tecnica iOS
//
//  Created by Etwan on 05/03/24.
//

import MessageKit

struct Messages: MessageType {
    var sender: MessageKit.SenderType
    var messageId: String
    var sentDate: Date
    var kind: MessageKit.MessageKind
}
