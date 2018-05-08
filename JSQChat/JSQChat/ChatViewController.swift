//
//  ViewController.swift
//  JSQChat
//
//  Created by Egon Fiedler on 5/3/18.
//  Copyright © 2018 App Solutions. All rights reserved.
//

import UIKit
import JSQMessagesViewController

class ChatViewController: JSQMessagesViewController {
    
    //Stores all the messages?
    var messages = [JSQMessage]()
    
    ////////////////////////////////////////////////////////////////////////////////////////////
    //
    //The bubbles in the messages
    //What a beautiful pattern for swift <mind blown away>
        //The variable is an actionable that works has long has it is been called automatically to begin various processes
    lazy var outgoingBubble: JSQMessagesBubbleImage = {
        return JSQMessagesBubbleImageFactory()!.outgoingMessagesBubbleImage(with: UIColor.jsq_messageBubbleBlue())
    }()
    
    lazy var incomingBubble: JSQMessagesBubbleImage = {
        return JSQMessagesBubbleImageFactory()!.incomingMessagesBubbleImage(with: UIColor.jsq_messageBubbleLightGray())
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        senderId = "1234"
        senderDisplayName = "Juan"
        
        inputToolbar.contentView.leftBarButtonItem = nil
        
        collectionView.collectionViewLayout.incomingAvatarViewSize = CGSize.zero
        collectionView.collectionViewLayout.outgoingAvatarViewSize = CGSize.zero
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //////////////////////////////////////////////////////////////////////////////////////////////
    //
    //Send messages
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!)
    {
        let ref = Constants.refs.databaseChats.childByAutoId()
        
        let message = ["sender_id": senderId, "name": senderDisplayName, "text": text]
        
        ref.setValue(message)
        
        finishSendingMessage()
    }
    
    //////////////////////////////////////////////////////////////////////////////////////////////
    //
    //Configuration and seting up of the chat
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData!
    {
        return messages[indexPath.item]
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource!
    {
        return messages[indexPath.item].senderId == senderId ? outgoingBubble : incomingBubble
    }
    //Called when the label text is needed
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, attributedTextForMessageBubbleTopLabelAt indexPath: IndexPath!) -> NSAttributedString!
    {
        return messages[indexPath.item].senderId == senderId ? nil : NSAttributedString(string: messages[indexPath.item].senderDisplayName)
    }
    //Called when the height of the top label is needed
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout!, heightForMessageBubbleTopLabelAt indexPath: IndexPath!) -> CGFloat
    {
        return messages[indexPath.item].senderId == senderId ? 0 : 15
                // x ? y = z
                //determine if the message is sent by the current user, or sent by someone else. Logically, if the current user sent the message, you don’t have to show their sender name, so the label stays empty and hidden.
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource!
    {
        return nil
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return messages.count
    }
}

