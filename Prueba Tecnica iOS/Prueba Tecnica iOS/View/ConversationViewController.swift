//
//  ConversationViewController.swift
//  Prueba Tecnica iOS
//
//  Created by Etwan on 24/02/24.
//
import MessageKit
import UIKit
import InputBarAccessoryView

class ConversationViewController: MessagesViewController, MessagesDataSource, MessagesLayoutDelegate, MessagesDisplayDelegate {
    
    let currentUser = Sender(senderId: "self", displayName: "Current User")
    let otherUser = Sender(senderId: "other", displayName: "Another User")
    
    var messages = [MessageType]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        
        self.navigationController?.navigationBar.isHidden = false
        self.title = "Chat"
        configureMessageInputBar()
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
    
    func configureMessageInputBar() {
      messageInputBar.delegate = self
      messageInputBar.inputTextView.tintColor = .secondaryColor
      messageInputBar.sendButton.setTitleColor(.secondaryColor, for: .normal)
      messageInputBar.sendButton.setTitleColor(
        UIColor.secondaryColor.withAlphaComponent(0.3),
        for: .highlighted)
    }
}

extension ConversationViewController: InputBarAccessoryViewDelegate {
    // MARK: Internal
    
    @objc
    func inputBar(_: InputBarAccessoryView, didPressSendButtonWith _: String) {
        processInputBar(messageInputBar)
    }
    
    func processInputBar(_ inputBar: InputBarAccessoryView) {
        // Here we can parse for which substrings were autocompleted
        let attributedText = inputBar.inputTextView.attributedText!
        let range = NSRange(location: 0, length: attributedText.length)
        attributedText.enumerateAttribute(.autocompleted, in: range, options: []) { _, range, _ in
            
            let substring = attributedText.attributedSubstring(from: range)
            let context = substring.attribute(.autocompletedContext, at: 0, effectiveRange: nil)
            print("Autocompleted: `", substring, "` with context: ", context ?? "-")
        }
        
        let components = inputBar.inputTextView.components
        inputBar.inputTextView.text = String()
        inputBar.invalidatePlugins()
        // Send button activity animation
        inputBar.sendButton.startAnimating()
        inputBar.inputTextView.placeholder = "Sending..."
        // Resign first responder for iPad split view
        inputBar.inputTextView.resignFirstResponder()
        DispatchQueue.global(qos: .default).async {
            // fake send request task
            sleep(1)
            DispatchQueue.main.async { [weak self] in
                inputBar.sendButton.stopAnimating()
                inputBar.inputTextView.placeholder = "Aa"
                self?.insertMessages(components)
                self?.messagesCollectionView.scrollToLastItem(animated: true)
            }
        }
    }
    
    private func insertMessages(_ data: [Any]) {
      for component in data {
        if let str = component as? String {
          let message = Messages(sender: currentUser, messageId: UUID().uuidString, sentDate: Date(), kind: .text(str))
            insertMessage(message)
        }
      }
    }
    
    func insertMessage(_ message: Messages) {
      messages.append(message)
      // Reload last section to update header/footer labels and insert a new one
      messagesCollectionView.performBatchUpdates({
        messagesCollectionView.insertSections([messages.count - 1])
        if messages.count >= 2 {
          messagesCollectionView.reloadSections([messages.count - 2])
        }
      }, completion: { [weak self] _ in
        if self?.isLastSectionVisible() == true {
          self?.messagesCollectionView.scrollToLastItem(animated: true)
        }
      })
    }
    
    func isLastSectionVisible() -> Bool {
      guard !messages.isEmpty else { return false }

      let lastIndexPath = IndexPath(item: 0, section: messages.count - 1)

      return messagesCollectionView.indexPathsForVisibleItems.contains(lastIndexPath)
    }
}
