//
//  Constants.swift
//  JSQChat
//
//  Created by Egon Fiedler on 5/7/18.
//  Copyright © 2018 App Solutions. All rights reserved.
//

import Foundation
import Firebase

//Nested struct to store variables in.
// Constants.refs.databaseChats
struct Constants
{
    struct refs
    {
        static let databaseRoot = Database.database().reference()
        static let databaseChats = databaseRoot.child("chats")
    }
}
