//
//  User.swift
//  fire
//
//  Created by Артём Коротков on 06.09.2022.
//
import Firebase
import Foundation

struct User {
    var uid: String
    var email: String
    
    init(user: Firebase.User) {
        self.uid = user.uid
        self.email = user.email!
    }
}
