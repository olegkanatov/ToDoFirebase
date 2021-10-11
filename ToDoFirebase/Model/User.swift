//
//  User.swift
//  ToDoFirebase
//
//  Created by Oleg Kanatov on 6.10.21.
//

import Foundation
import Firebase

struct Users {
    
    let uid: String
    let email: String
    
    init(user: Firebase.User) {
        self.uid = user.uid
        self.email = user.email!
    }
}

