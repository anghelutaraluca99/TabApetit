//
//  User.swift
//  ChatApp
//
//  Created by Raluca Angheluta on 25/06/2017.
//  Copyright © 2017 Raluca Angheluta. All rights reserved.
//

import UIKit

class User: NSObject {
    var name: String?
    var email: String?
    var profileImageURL: String?
    var Description: String?
    
    override init(){
        self.name = "nume"
        self.email = "email"
        self.profileImageURL = "poza"
        self.Description = "descriere"
    }
    
    func getFromJson(json: [String: Any]) {
        name = json["name"] as? String ?? "nu exista"
        email = json["email"] as? String ?? "nu exista"
        profileImageURL = json["profileImageURL"] as? String ?? "nu exista"
        Description = json["Description"] as? String ?? "nu exista"
    }
}
